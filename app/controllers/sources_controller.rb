class SourcesController < ApplicationController
  skip_before_action :set_default_request_format

  API    = 'http://59c2b57488c2c400118df06c.mockapi.io'.freeze
  CLIENT = Client::Services::MockSourceService.new(host: API, logger: Rails.logger)

  def show
    result = CLIENT.sources.find(params[:id])
    if result.success?
      @source = result.body
    else
      request.format = :json
      errors(result.body[:errors], 422)
    end
  end

  def index
    result = CLIENT.sources.all
    if result.success?
      @sources = result.body
    else
      request.format = :json
      errors(result.body[:errors], 422)
    end
  end
end
