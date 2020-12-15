# The Civil Service gem is nice, but it forces you to declare a Result object with exactly when you are returning.
# This is a dynamic version of that so you can return any hash and it will auto-create the attributes for you.
class GenericResult
  include ActiveModel::Model
  attr_accessor :exception
  attr_writer :errors

  def self.success(attributes = {})
    new(attributes.merge(success: true))
  end

  def self.failure(attributes = {})
    new(attributes.merge(success: false))
  end

  # https://cobwwweb.com/dynamic-attributes-on-instances-in-ruby
  def initialize(attributes = {})
    attributes.each do |attr, value|
      # Setter
      define_singleton_method("#{attr}=") { |val| attributes[attr] = val }

      # Getter
      define_singleton_method(attr) { attributes[attr] }
    end

    super
  end

  def success?
    success
  end

  def failure?
    !success?
  end

  def errors
    @errors ||= ActiveModel::Errors.new(self)
  end
end
