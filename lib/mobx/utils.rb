module Mobx
  module Utils
    def in?(name)
      return false if Thread.current['mobx'][name].nil?

      if Thread.current['mobx'][name].respond_to?(:empty?)
        !Thread.current['mobx'][name].empty?
      else
        true
      end
    end

    def wrapped(name, object, &block)
      Thread.current['mobx'][name] << object
      block.call
      Thread.current['mobx'][name].pop
    end

    def wrappedOnce(name, object, &block)
      Thread.current['mobx'][name] ||= object
      block.call
      Thread.current['mobx'][name] = nil
    end

    def state(name)
      Thread.current['mobx'][name]
    end
  end
end