require 'spec_helper'
require 'support/activerecord'

def create_table(name)
  ActiveRecord::Base.connection.create_table(name, force: true) do |t|
    t.column :image, :string
    t.column :images, :json
    t.column :textfile, :string
    t.column :textfiles, :json
    t.column :foo, :string
  end
end

def drop_table(name)
  ActiveRecord::Base.connection.drop_table(name)
end

def reset_class(class_name)
  Object.send(:remove_const, class_name) rescue nil
  Object.const_set(class_name, Class.new(ActiveRecord::Base))
end

describe ImagizerEngine::ActiveRecord do
  before(:all) { create_table("artworks") }
  after(:all) { drop_table("artworks") }

  before do
    reset_class("Artwork")
    Artwork.class_eval do 
      mount_imagizer_engine :main_image, :my_original_image_url 

      def my_original_image_url
        "path/to/file.png"
      end
    end
    @artwork = Artwork.new
  end

  after do
    Artwork.delete_all
  end

  describe("ImagizerEngine::Mount") do 
    
    it "should respond to main_image_url" do
      expect(@artwork).to respond_to(:main_image_url)
    end

  end

end
