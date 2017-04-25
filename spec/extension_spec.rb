require 'spec_helper'

describe Mobx::Extension do
  it 'creates autorun' do
    expect { Mobx.autorun {} }.to_not raise_error
  end

  it 'creates reaction' do
    block = proc {}
    expect(block).to receive(:call).once

    observable = Mobx::Observable.new(1)
    Mobx.reaction(-> { observable.get }, &block)

    observable.set(2)
  end

  it 'creates action' do
    transaction = Mobx.action {}

    expect {
      transaction = Mobx.action {}
      expect(transaction).to be_a(Mobx::Transaction)
    }.to_not raise_error
  end

  describe 'observable' do
    let(:klass) do
      Class.new do
        attr_reader :__mobx_observables
        include Mobx::Extension

        observable :variable
        observable :number, 123
      end
    end

    let(:instance) { klass.new }

    it 'creates property getter' do
      expect(instance.variable).to eq(nil)
      expect(instance.__mobx_observables[:variable]).to be_a(Mobx::Observable)
    end

    it 'creates property getter with default value' do
      expect(instance.number).to eq(123)
      expect(instance.__mobx_observables[:number]).to be_a(Mobx::Observable)
    end

    it 'creates observable property setter' do
      instance.number = 456
      expect(instance.number).to eq(456)
    end

    it 'does not create new observable object on setting' do
      instance.number = 123
      before = instance.__mobx_observables[:number].object_id

      instance.number = 456
      after  = instance.__mobx_observables[:number].object_id

      expect(before).to eq(after)
    end
  end
end