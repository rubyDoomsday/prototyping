class ApplicationController < ActionController::Base
  before_action :set_default_request_format
  respond_to :json
  protect_from_forgery with: :exception

  def raise_not_found!
    errors(["No route matches #{params[:unmatched_route]}"], 404)
  end

  private

  def set_default_request_format
    request.format = :json
  end

  def errors(errors, status)
    @errors = errors
    render('common/error', status: status)
  end
end
