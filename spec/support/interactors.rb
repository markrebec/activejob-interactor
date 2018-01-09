class IncludedInteractor
  include ::Interactor
  include ActiveJob::Interactor
end

class WithoutInteractor
  include ActiveJob::Interactor
end

class FailingInteractor
  include ActiveJob::Interactor

  def call
    context.fail!(error: StandardError.new('this is a test error'))
  end
end
