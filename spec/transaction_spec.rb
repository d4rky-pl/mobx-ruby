require 'spec_helper'

describe Mobx::Transaction do
  it 'only schedules observers once' do
    observer = Mobx::Autorun.new(proc {})
    transaction = Mobx::Transaction.new(proc {})

    5.times { transaction.schedule_observer(observer) }
    expect(transaction.scheduled.length).to eq(1)
  end

  it 'runs observers after outermost transaction is over' do
    block = proc {}
    expect(block).to receive(:call).once

    observable = Mobx::Observable.new(nil)
    observer = Mobx::Autorun.new(block)
    observer.register_observable(observable)

    transactionA = Mobx::Transaction.call(-> {
      Mobx::Transaction.call(-> {
        observable.set(1)
      })
    })
  end

  it 'schedules observers on outermost transaction' do
    observable = Mobx::Observable.new(nil)
    observer = Mobx::Autorun.new(proc {})
    observer.register_observable(observable)

    transaction = Mobx::Transaction.new(-> {
      Mobx::Transaction.call(-> {
        observable.set(1)
      });
    })

    expect(transaction).to receive(:schedule_observers).with([observer]).and_call_original
    transaction.call
  end
end
