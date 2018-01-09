require 'spec_helper'

RSpec.describe ActiveJob::Interactor::Job do

  describe '#interactor' do
    context 'when using the built-in job class' do
      context 'with a valid interactor class argument' do
        it 'returns the interactor class'
      end

      context 'with an invalid interactor class argument' do
        it 'raises a NameError'
      end
    end

    context 'when using a custom job class' do
      it 'infers the interactor class from the job class name'

      context 'with a valid interactor class' do
        it 'returns the interactor class'
      end

      context 'with an invalid interactor class' do
        it 'raises a NameError'
      end
    end
  end

  describe '#perform' do
    it 'calls the interactor with the provided context'

    context 'when the interactor fails' do
      it 'raises an ActiveJob::Interactor::JobFailure'
    end
  end
end
