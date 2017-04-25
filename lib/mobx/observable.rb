require 'pry'
module Mobx
  class Observable
    attr_reader :observers
    
    def initialize(value)
      @value = value
      @observers = []
    end

    def get
      register_autorun_observers
      @value
    end

    alias_method :value, :get

    def set(value)
      register_autorun_observers

      if !(@value === value)
        @value = value

        if Mobx.in?(:transaction)
          Mobx.state(:transaction).schedule_observers(@observers)
        else
          @observers.each { |observer| observer.call }
        end
      end
      @value
    end
    
    def dispose(observer)
      @observers.delete(observer)
    end

    def register_observer(observer)
      unless @observers.include?(observer)
        @observers << observer
        @observers.uniq!
        observer.register_observable(self)
      end
    end

    protected
    def register_autorun_observers
      return unless Mobx.in?(:autorun)
      Mobx.state(:autorun).each { |observer| register_observer(observer) }
    end
  end
end
