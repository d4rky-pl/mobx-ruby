module Mobx
  class Autorun
    attr_reader :observables, :disposed

    def initialize(block)
      @block = block
      @observables = []
      @disposed = false
    end

    def call
      @block.call unless disposed
    end

    def register_observable(observable)
      raise 'Trying to register a disposed Autorun' if disposed
      unless @observables.include?(observable)
        @observables << observable
        @observables.uniq!

        observable.register_observer(self)
      end
    end

    def dispose
      @observables.each { |observable| observable.dispose(self) }
      @observables = []
      @disposed = true
    end
  end
end
