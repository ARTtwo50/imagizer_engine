# ImagizerEngine

This gem adds a thin wrapper around the Imagizer Media Engine service by Nventify. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'imagizer_engine'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install imagizer_engine

## Configure

Rails

1. Create a config file like config/imagizer_engine.rb 
2. Define the host (either IP or URL) found in your EC2 instance.
3. Define all of the different versions available to use.
4. Use the Imagizer API to configure each of the different versions. All of the Image API parameters are supported. http://demo.imagizercdn.com/doc/
```ruby
ImagizerEngine.host = "141.123.12.9"
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

  version :preview,
    :processes => {
      quality: 80
    }
end
```

## Usage

In the class that has the original image url, invoke `mount_imagizer_engine' method. This method takes two parameters: the image name and the method to be called to get the original url of the image.

```ruby
class User
  extend ImagizerEngine::Mount #this line is not necessary if you're using Rails with ActiveRecord 
  mount_imagizer_engine :profile_image, :original_url_method_name
  
end
```
Since we passed `:original_url_method_name` as the method which contains the full image url, we should define it somehow. It can be a column if using on Rails/ActiveRecord for instance, or simply define:

```ruby
class User

  def original_url_method_name
    "http://s3aws.address/my_original_image.png"
  end
end
```

To use the Imagizer Engine use the `profile_image_url()` method. This also takes an optional parameter that could be one of the versions defined in the config file

```
user = User.new
user.profile_image_url() => "http://143.123.12.9/path/to/file"
user.profile_image_url(:cover) => "http://143.123.12.9/path/to/file?scale=2&crop1,2,3,4"

```


## Contributing

1. Fork it ( https://github.com/[my-github-username]/imagizer_engine/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
