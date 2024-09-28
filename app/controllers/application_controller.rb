class ApplicationController < ActionController::Base
  def first_error(record)
    record.errors.full_messages.first
  end
end
