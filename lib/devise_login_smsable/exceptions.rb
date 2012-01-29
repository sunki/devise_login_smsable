class DeviseLoginSmsable::UnknownModel < StandardError
  def message
    'Model with specified name not found'
  end
end