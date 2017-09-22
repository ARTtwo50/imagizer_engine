require 'net/http'
require 'json'

module ImagizerEngine
  module Mount
    def mount_imagizer_engine(column, original_url_method)

      self.send(:define_method, "#{column}_url") do |version=nil|
        raise NoMethodError, "there's no instance method called #{original_url_method}" unless respond_to?(original_url_method)
        ImagizerEngine::Url.new.to_url(self.send(original_url_method), version)
      end

      self.send(:define_method, "#{column}_metadata_url") do ||
        raise NoMethodError, "there's no instance method called #{original_url_method}" unless respond_to?(original_url_method)
        ImagizerEngine::Url.new.to_url(self.send(original_url_method), nil, true)
      end

      self.send(:define_method, "#{column}_metadata") do ||
        raise NoMethodError, "there's no instance method called #{original_url_method}" unless respond_to?(original_url_method)
        url = send("#{column}_metadata_url")
        response = Net::HTTP.get(url)
        JSON.parse(response)
      end

    end
  end
end