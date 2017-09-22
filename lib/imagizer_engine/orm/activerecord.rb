require 'active_record'

module ImagizerEngine
  module ActiveRecord

    include ImagizerEngine::Mount


  end # ActiveRecord
end # ImagizerEngine

ActiveRecord::Base.extend ImagizerEngine::ActiveRecord