class IncludedInteractor
  include ::Interactor
  #include ActiveJob::Interactor
end

class WithoutInteractor
  #include ActiveJob::Interactor
end
