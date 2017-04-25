require 'spec_helper'

describe Mobx::Autorun do 
  let(:autorun) { Mobx::Autorun.new(proc {}) }
  let(:observable) { Mobx::Observable.new(nil) }
  it 'only registers observables once' do
    5.times { autorun.register_observable(observable) }

    expect(autorun.instance_variable_get('@observables').length).to eq(1)
  end

  it 'disposes itself' do
    observable.register_observer(autorun)
    
    expect(observable.observers.length).to eq(1)
    expect(autorun.observables.length).to eq(1)

    autorun.dispose
    
    expect(observable.observers.length).to eq(0)
    expect(autorun.observables.length).to eq(0)
  end

  it 'crashes when trying to register after it was disposed' do
    autorun.dispose

    expect {
      observable.register_observer(autorun)
    }.to raise_error(/Trying to register a disposed Autorun/)
  end
end