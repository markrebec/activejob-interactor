require 'active_job/interactor/job'

module ActiveJob
  module Interactor
    extend ActiveSupport::Concern

    class_methods do
      def job=(klass)
        @job = klass
      end

      def job
        @job || "#{self.name}Job".constantize
      rescue NameError => e
        ActiveJob::Interactor::Job
      end

      def call_later(*args, **context)
        if job == ActiveJob::Interactor::Job
          job.perform_later(*[self.name].concat(args), **context)
        else
          job.perform_later(*args, **context)
        end
      end
      alias_method :perform_later, :call_later
    end
  end
end
