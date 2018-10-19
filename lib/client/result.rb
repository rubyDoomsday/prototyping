module Client
  ##
  # Status object to capture result from an HTTP request
  #
  # Gives callers context of the result and allows them to
  # implement successful strategies to handle success/failure
  #
  class Result
    def self.success(response)
      new(:success, response)
    end

    def self.failed(response)
      new(:failed, response)
    end

    attr_reader :status, :code, :headers, :body

    def initialize(status, response)
      @status = status
      @code = response.code
      @body = clean_parse(response.body)
      # RestClient::AbstractResponse#headers returns beautified headers hash
      # e.g. "Content-Type" will become :content_type.
      @headers = response.headers
    end

    def success?
      @status == :success
    end

    def failure?
      @status == :failed
    end

    def to_h
      { status: @status, code: @code, headers: @headers, body: @body }
    end

    alias to_hash to_h

    def method_missing(method, *args, &blk)
      to_h.send(method, *args, &blk)
    end

    def respond_to_missing?(method, include_private = false)
      to_h.respond_to?(method) || super
    end

    # @param [JSON] body Raw JSON body
    def clean_parse(body)
      return unless body && body.length >= 2
      JSON.parse(body, symbolize_names: true)
    rescue
      raise RuntimeError.new("(#{@status}: #{@code}) Response body is not JSON")
    end
  end
end
