module ImagizerEngine
  module Mount
    def mount_imagizer_engine(column, original_url_method)

      self.send(:define_method, "#{column}_url") do |version=nil|
        raise NoMethodError, "there's no instance method called #{original_url_method}" unless respond_to?(original_url_method)
        ImagizerEngine::Url.new.to_url(self.send(original_url_method), version)
      end

    end
  end
end