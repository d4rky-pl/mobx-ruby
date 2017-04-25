module Mobx
  module Extension
    module ClassMethods
      def observable(attr_name, value=nil)
        define_method(attr_name) do
          @__mobx_observables ||= {}
          @__mobx_observables[attr_name] ||= Mobx::Observable.new(value)
          @__mobx_observables[attr_name].get 
        end

        define_method("#{attr_name}=") do |value|
          @__mobx_observables ||= {}
          if @__mobx_observables.has_key?(attr_name)
            @__mobx_observables[attr_name].set(value)
          else  
            @__mobx_observables[attr_name] = Mobx::Observable.new(value) 
          end
        end
      end
    end
    module InstanceMethods
      def autorun(&block)
        reaction(block, &block)
      end

      def reaction(react_when, &block)
        autorun = Mobx::Autorun.new(block)
        Mobx.wrapped :autorun, autorun, &react_when
        autorun
      end  

      def action(&block)
        Mobx::Transaction.call(block)
      end

      alias_method :transaction, :action
    end

    def self.included(base)
      base.send :include, InstanceMethods
      base.send :extend, ClassMethods
    end
  end
end
