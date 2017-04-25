require 'mobx/autorun'
require 'mobx/transaction'
require 'mobx/observable'
require 'mobx/computed'
require 'mobx/extension'
require 'mobx/utils'

module Mobx
  extend Mobx::Utils
  extend Mobx::Extension::InstanceMethods

  def self.init
    Thread.current['mobx'] ||= {
      autorun: [],
      transaction: nil
    }
  end
end