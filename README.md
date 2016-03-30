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
2. Define the public ip found in your EC2 instance.
3. Define all of the different versions available to use.
4. Use the Imagizer API to configure each of the different versions. All of the Image API parameters are supported. http://demo.imagizercdn.com/doc/
```ruby
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

  version :preview,
    :processes => {
      quality: 80
    }
end
```

## Usage

1.In the class associated with the image invoke `mount_engine' method

This method takes a single parameter that defines an image prefix

```
class User

  mount_engine :profile_image

end
```
2.With the `profile_image` prefix you will need to define a `profile_image_original_url` method in your class. This method should define the original url of the image.
```
class User

  def profile_image_original_url
    "path/to/file"
  end
```
3.To use the Imagizer Engine use the `profile_image_url()` method. This also takes an optional parameter that could be one of the versions defined in the config file

```
user = User.new
user.profile_image_url() => "http://143.123.12.9/c/path/to/file"
user.profile_image_url(:cover) => "http://143.123.12.9/c/path/to/file?scale=2&crop1,2,3,4"

```

4.Profit

## Contributing

1. Fork it ( https://github.com/[my-github-username]/imagizer_engine/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
