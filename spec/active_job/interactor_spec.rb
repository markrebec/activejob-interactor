require 'spec_helper'

RSpec.describe ActiveJob::Interactor do
  before do
    TestInteractor = Class.new
    TestInteractor.send :include, ActiveJob::Interactor
  end

  after do
    Object.send :remove_const, 'TestInteractor'
  end

  describe '.job=' do
    it 'sets the job class for the interactor' do
      TestInteractor.job = InteractorTestJob
      expect(TestInteractor.instance_variable_get :@job).to eq(InteractorTestJob)
    end
  end

  describe '.job' do
    context 'when a job class has been set' do
      it 'uses the defined job class' do
        TestInteractor.job = InteractorTestJob
        expect(TestInteractor.job).to eq(InteractorTestJob)
      end
    end

    context 'when a job class has not been set' do
      it 'infers the job class from the interactor class name' do
        TestInteractorJob = Class.new(ActiveJob::Base)
        expect(TestInteractor.job).to eq(TestInteractorJob)
        Object.send :remove_const, 'TestInteractorJob'
      end

      context 'when the inferred job class does not exist' do
        it 'falls back to the built-in job class' do
          expect(TestInteractor.job).to eq(ActiveJob::Interactor::Job)
        end
      end
    end
  end

  describe '.call_later' do
    it 'invokes the job #perform_later method' do
      TestInteractorJob = Class.new(ActiveJob::Base)
      expect(TestInteractorJob).to receive(:perform_later)
      TestInteractor.call_later
      Object.send :remove_const, 'TestInteractorJob'
    end

    context 'with a defined job class' do
      it 'does not pass the interactor class name through the job arguments' do
        TestInteractorJob = Class.new(ActiveJob::Base)
        expect(TestInteractorJob).to receive(:perform_later).with({foo: :bar})
        TestInteractor.call_later({foo: :bar})
        Object.send :remove_const, 'TestInteractorJob'
      end
    end

    context 'with the built-in job class' do
      it 'passes the interactor class name as the first argument' do
        expect(ActiveJob::Interactor::Job).to receive(:perform_later).with('TestInteractor', {foo: :bar})
        TestInteractor.call_later({foo: :bar})
      end
    end
  end
end
