require 'spec_helper'

describe ImagizerEngine do

  before do
    @class = Class.new
    @class.send(:extend, ImagizerEngine::Mount)

    @class.mount_imagizer_engine(:image, :image_original_url)
    @class.mount_imagizer_engine(:cover, :image_original_url)
    @instance = @class.new
    @instance.define_singleton_method(:image_original_url) do
      "path/to/file.png"
    end

    ImagizerEngine.public_ip = "141.123.12.9"

    ImagizerEngine.configure do
      version :thumb, 
        :processes => {
          width: 250,
          height: 100,
          scale: 1
        }
      
      version :cover, 
        :parent => :thumb,
        :processes => {
          scale: 2,
          crop: [1,2,3,4]
        }

      version :invalid,
        :processes => {
          test: 100
        }
    end
  end

  it "should send the correct url without a version" do
    expect(@instance.image_url).to eq("http://141.123.12.9/path/to/file.png")
  end

  it "should send the correct url with a version" do
    expect(@instance.image_url(:cover)).to eq("http://141.123.12.9/path/to/file.png?width=250&height=100&scale=2&crop=1,2,3,4")
  end

  it "should raise error if `cover_original_url is not defined" do
    @class.mount_imagizer_engine(:main, :undefined_method)
    instance = @class.new
    expect{instance.main_url}.to raise_error(NoMethodError)
  end

  it "should have `_url method defined" do
    expect(@instance.respond_to?(:image_url)).to be true
  end

  it "should allow configuring of #public_ip" do
    ImagizerEngine.public_ip = "1.2.3.4"
    expect(ImagizerEngine.public_ip).to eq("1.2.3.4")
  end

  it "should ignore keys that are not used in the Imagizer API" do
    expect(@instance.image_url(:invalid)).to eq("http://141.123.12.9/path/to/file.png")
  end
  
end