module Mobx
  class Computed
    attr_reader :value

    def initialize(block)
      @disposer = Mobx.autorun { @value = block.call }
    end
  end
end