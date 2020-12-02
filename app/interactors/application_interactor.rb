class ApplicationInteractor < CivilService::Service
  class_attribute :result_class # Need this so it wil be inherited
  self.result_class = GenericResult
end