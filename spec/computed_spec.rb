require 'spec_helper'

describe Mobx::Computed do 
  it 'automatically derivates value from observable' do
    observable = Mobx::Observable.new(1)
    computed = Mobx::Computed.new(-> {
      observable.value * 10
    })

    expect(computed.value).to eq(10)

    observable.set(2)
    expect(computed.value).to eq(20)
  end
end