class ApplicationController < ActionController::Base
  def hi
      render html: 'hi'
  end
end
