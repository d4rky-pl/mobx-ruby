module Mobx
  class Transaction
    attr_reader :scheduled

    def initialize(block)
      @block = block
      @scheduled = []
    end 

    def self.call(block)
      transaction = self.new(block)
      transaction.call
    end  

    def call
      Mobx.wrappedOnce(:transaction, self, &@block)

      unless Mobx.in?(:transaction)
        @scheduled.each(&:call)
        @scheduled = []
      end
      self
    end

    def schedule_observers(observers)
      observers.each { |observer| schedule_observer(observer) }
    end

    def schedule_observer(observer)
      @scheduled << observer
      @scheduled.uniq!
    end 
  end
end
