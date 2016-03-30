require "imagizer_engine/version"
require "imagizer_engine/mount"
module ImagizerEngine
  extend self  

  def public_ip
    @public_ip ||= "0.0.0.0"
  end

  def public_ip=(ip)
    @public_ip = ip
  end
 
  def configure(&block)
    instance_eval(&block)
  end

  def definitions
    @definitions ||= Hash.new
  end

  def version(name, options={})  
    definitions[name.to_sym] = Version.new(name, options)
  end

  def [](name)
    definitions[name.to_sym]
  end

  class Version

    @@valid_config_keys = [:scale, :crop, :width, :height, :quality, :dpr, :filter]

    def initialize(name, options)
      @name        = name.to_sym
      @processes = options[:processes]
      @parent      = options[:parent]
    end

    attr_reader :parent

    def processes
      return validated_processes unless parent
      ImagizerEngine[parent].processes.merge(validated_processes)      
    end

    def validated_processes
      @processes.select{|key| @@valid_config_keys.include? key.to_sym}
    end
  end

end

require "imagizer_engine/url"

