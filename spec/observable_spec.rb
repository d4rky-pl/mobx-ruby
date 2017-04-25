require 'spec_helper'

describe Mobx::Observable do 
  it 'automatically registers autorun observers' do
    observableA = Mobx::Observable.new(1)
    observableB = Mobx::Observable.new(2)

    Mobx.autorun do
      observableA.get
      observableB.set(3)
    end

    expect(observableA.observers.length).to eq(1)
    expect(observableB.observers.length).to eq(1)
  end

  it 'automatically registers transaction observers' do
    observable = Mobx::Observable.new(1)
    Mobx.autorun { observable.get }

    transaction = Mobx::Transaction.new(-> { 
      observable.set(2)
    })
    expect(transaction).to receive(:schedule_observers).once.and_call_original

    transaction.call
  end
end