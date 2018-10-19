require 'active_support'
require 'active_support/core_ext/object'
require 'rest_client'
require_relative 'result'
require_relative 'services'

module Client
  class Error < RuntimeError
    def initialize(message)
      super(message)
    end
  end

  class Base
    attr_reader :host, :logger

    def initialize(host:, logger: nil)
      @host = host
      @logger = logger
    end

    def get(uri, options = {}, headers = {})
      request do
        url = base_url + uri

        # Guard against nil value params. Defaults in params definition are only applied if param
        # not present.
        options ||= {}
        headers ||= {}

        query_params = CGI.unescape(options.to_query)
        url += '?' + query_params unless query_params.blank?

        response = RestClient::Request.execute(method: :get,
                                               url: url,
                                               headers: default_headers.merge(headers),
                                               open_timeout: open_timeout,
                                               timeout: timeout)

        logger.debug { "Request: GET #{url}; options=#{options} status: #{response.code}" } if logger
        response.code == 200 ? Result.success(response) : Result.failed(response)
      end
    end

    def post(payload, uri, options = {}, headers = {})
      request do
        url = base_url + uri
        payload = payload.to_json

        # Guard against nil value params. Defaults in params definition are only applied if param
        # not present.
        options ||= {}
        headers ||= {}

        query_params = CGI.unescape(options.to_query)
        url += '?' + query_params unless query_params.blank?

        response = RestClient::Request.execute(method: :post,
                                               url: url,
                                               payload: payload,
                                               headers: default_headers.merge(headers),
                                               open_timeout: open_timeout,
                                               timeout: timeout)

        logger.debug { "Request: POST #{url}; payload=#{payload} options=#{options} status: #{response.code}" } if logger

        response.code.in?([200, 201, 202]) ? Result.success(response) : Result.failed(response)
      end
    end

    def put(payload, uri, options = {}, headers = {})
      request do
        url = base_url + uri
        payload = payload.to_json

        # Guard against nil value params. Defaults in params definition are only applied if param
        # not present.
        options ||= {}
        headers ||= {}

        query_params = CGI.unescape(options.to_query)
        url += '?' + query_params unless query_params.blank?

        response = RestClient::Request.execute(method: :put,
                                               url: url,
                                               payload: payload,
                                               headers: default_headers.merge(headers),
                                               open_timeout: open_timeout,
                                               timeout: timeout)

        logger.debug { "Request: PUT #{url}; payload=#{payload} options=#{options} status: #{response.code}" } if logger

        response.code.in?([200, 204]) ? Result.success(response) : Result.failed(response)
      end
    end

    def patch(payload, uri, options = {}, headers = {})
      request do
        url = base_url + uri
        payload = payload.to_json

        # Guard against nil value params. Defaults in params definition are only applied if param
        # not present.
        options ||= {}
        headers ||= {}

        query_params = CGI.unescape(options.to_query)
        url += '?' + query_params unless query_params.blank?

        response = RestClient::Request.execute(method: :patch,
                                               url: url,
                                               payload: payload,
                                               headers: default_headers.merge(headers),
                                               open_timeout: open_timeout,
                                               timeout: timeout)

        logger.debug { "Request: PATCH #{url}; payload=#{payload} options=#{options} status: #{response.code}" } if logger

        response.code == 200 ? Result.success(response) : Result.failed(response)
      end
    end

    def delete(uri, options = {}, headers = {})
      delete_with_payload(nil, uri, options, headers)
    end

    def delete_with_payload(payload, uri, options = {}, headers = {})
      request do
        url = base_url + uri

        # Guard against nil value params. Defaults in params definition are only applied if param
        # not present.
        options ||= {}
        headers ||= {}

        query_params = CGI.unescape(options.to_query)
        url += '?' + query_params unless query_params.blank?

        response = RestClient::Request.execute(method: :delete,
                                               url: url,
                                               payload: payload,
                                               headers: default_headers.merge(headers),
                                               open_timeout: open_timeout,
                                               timeout: timeout)

        logger.debug { "Request: DELETE #{url}; payload=#{payload} options=#{options} status: #{response.code}" } if logger
        response.code == 200 ? Result.success(response) : Result.failed(response)
      end
    end

    def request
      result = yield

      if result.success?
        logger.debug { "Response: status=#{result.code}, body=#{result.body}" } if logger
      else
        logger.warn { "Request Error: status=#{result.code}, body=#{result.body}" } if logger
      end

      result
    rescue ::RestClient::GatewayTimeout
      raise Error.new('Gateway timeout')
    rescue ::RestClient::RequestTimeout
      raise Error.new('Request timeout')
    rescue ::RestClient::Exception => e
      handle_error(e)
    end

    def handle_error(e)
      response = e.response
      message = e.message

      logger.error { "Request Error: status=#{response.code}, body=#{response}; #{message}" } if logger

      Result.failed(response)
    end

    def base_url
      @base_url ||= host.to_s
    end

    def default_headers
      headers = {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json',
      }

      headers['Request-Chain'] = Thread.current[:request_chain].join('|') unless Thread.current[:request_chain].nil?
      headers
    end

    def open_timeout
      @open_timeout || 5
    end

    def timeout
      @timeout || 5
    end
  end
end
