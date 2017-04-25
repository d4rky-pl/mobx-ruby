require 'spec_helper'

describe Mobx do
  it 'initializes state on init' do
    expect(Thread.current['mobx']).to_not be_nil
  end

  it 'detects being in transaction' do
    block = proc do 
      expect(Mobx.in?(:transaction)).to be_truthy      
    end

    expect(block).to receive(:call).and_call_original
    Mobx::Transaction.call(block)
  end

  it 'detects being in autorun block' do
    block = proc do
      expect(Mobx.in?(:autorun)).to be_truthy
    end    
    expect(block).to receive(:call).and_call_original

    autorun = Mobx::Autorun.new(block)
    Mobx.wrapped(:autorun, autorun, &block)
  end
end
