module ImagizerEngine
  class Url
    def to_url(url, version)
      protocol = ImagizerEngine.use_ssl ? 'https://' : 'http://'
      protocol + ImagizerEngine.host + "/" + sanitized_url(url) + process_params(version)
    end

    private

    def sanitized_url(url)
      url.sub(/^https?\:\/\/?([\da-z\.-]+)\.([a-z\.]{2,6}\/)/, '')
    end

    def process_params(version)
      return "" if version.nil? || ImagizerEngine[version].nil?
      temp_params = serialized_processes(version)
      temp_params.empty? ? "" : "?" + temp_params
    end

    def serialized_processes(version)
      ImagizerEngine[version].processes.map{|k,v| "#{k}=#{sanitized_value(v)}"}.join('&')
    end

    def sanitized_value(value)
      value.kind_of?(Array) ? value.join(',') : value
    end

  end
end