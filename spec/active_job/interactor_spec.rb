require 'spec_helper'

RSpec.describe ActiveJob::Interactor do

  describe '.included' do
    # TODO what's the best way to test this?
    #
    #context 'when the class has already included the Interactor mixin' do
    #  it 'does not include it again' do
    #    expect(IncludedInteractor.ancestors).to include(::Interactor)
    #  end
    #end
    #
    #context 'when the class has not included the Interactor mixin' do
    #end
  end

  describe '.job=' do
    it 'sets the job class for the interactor'
  end

  describe '.job' do
    context 'when a job class has been set' do
      it 'uses the defined job class'
    end

    context 'when a job class has not been set' do
      it 'infers the job class from the interactor class name'

      context 'when the inferred job class does not exist' do
        it 'falls back to the built-in job class'
      end
    end
  end

  describe '.call_later' do
    it 'invokes the job #perform_later method'

    context 'with a defined job class' do
      it 'does not pass the interactor class name through the job arguments'
    end

    context 'with the built-in job class' do
      it 'passes the interactor class name as the first argument'
    end
  end
end
