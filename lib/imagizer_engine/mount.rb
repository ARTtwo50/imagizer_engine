module ImagizerEngine
  module Mount
    def mount_engine(column)
      mod = Module.new
      include mod
      mod.class_eval <<-RUBY, __FILE__, __LINE__+1

        def #{column}_url(version=nil)
          raise NoMethodError, "define `#{column}_original_url' for #{self.inspect}" unless respond_to?(:#{column}_original_url)
          to_imagizer_url(((#{column}_original_url)), version)         
        end

        private

        def to_imagizer_url(url, version)
          Url.new.to_url(url, version)          
        end
        
      RUBY
    end    
  end
end
