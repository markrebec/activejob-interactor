require 'spec_helper'

RSpec.describe ActiveJob::Interactor::Job do

  describe '#interactor' do
    context 'when using the built-in job class' do
      context 'with a valid interactor class argument' do
        it 'returns the interactor class' do
          expect(ActiveJob::Interactor::Job.new('IncludedInteractor').interactor).to eq(IncludedInteractor)
        end
      end

      context 'with an invalid interactor class argument' do
        it 'raises a NameError' do
          expect { ActiveJob::Interactor::Job.new('FooBarInteractor').interactor }.to raise_exception(ArgumentError)
        end
      end
    end

    context 'when using a custom job class' do
      it 'infers the interactor class from the job class name' do
        expect(IncludedInteractorJob.new.interactor).to eq(IncludedInteractor)
      end

      context 'with a valid interactor class' do
        it 'returns the interactor class' do
          expect(IncludedInteractorJob.new.interactor).to eq(IncludedInteractor)
        end
      end

      context 'with an invalid interactor class' do
        it 'raises a NameError' do
          expect { InteractorTestJob.new.interactor }.to raise_exception(NameError)
        end
      end
    end
  end

  describe '#perform' do
    it 'calls the interactor with the provided context' do
      expect(IncludedInteractor).to receive(:call).and_return(Interactor::Context.new)
      IncludedInteractorJob.new.perform
    end

    context 'when the interactor fails' do
      it 'raises an ActiveJob::Interactor::JobFailure' do
        expect { FailingInteractorJob.new.perform }.to raise_exception(ActiveJob::Interactor::JobFailure)
      end
    end
  end
end
