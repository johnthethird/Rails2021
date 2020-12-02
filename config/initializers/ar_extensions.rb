ActiveRecord::Base.class_eval do
  def self.random
    if (c = count) != 0
      offset(rand(c)).first
    end
  end
end
