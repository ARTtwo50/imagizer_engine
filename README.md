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
Also, there's a method that will return the image metadata parsed JSON: 
```
user.profile_image_metadata => {
fileSize: 4428575,
width: 4032,
height: 3024,
fileType: "jpeg",
mimeType: "image/jpeg",
hasAlpha: false,
colorSpace: "srgb",
exif: {
ApertureValue: "2159/1273",
BrightnessValue: "3497/314",
ComponentsConfiguration: "1, 2, 3, 0",
DateTime: "2017:04:02 16:08:21",
DateTimeDigitized: "2017:04:02 16:08:21",
DateTimeOriginal: "2017:04:02 16:08:21",
ExifImageLength: 3024,
ExifImageWidth: 4032,
ExifOffset: 180,
ExifVersion: "48, 50, 50, 49",
ExposureBiasValue: "0/1",
ExposureMode: 0,
ExposureProgram: 2,
ExposureTime: "1/3690",
Flash: 24,
FlashPixVersion: "48, 49, 48, 48",
FNumber: "9/5",
FocalLength: "399/100",
FocalLengthIn35mmFilm: 28,
ISOSpeedRatings: 20,
Make: "Apple",
MeteringMode: 5,
Model: "iPhone 7",
Orientation: 1,
ResolutionUnit: 2,
SceneCaptureType: 0,
SceneType: 1,
SensingMethod: 2,
ShutterSpeedValue: "29588/2497",
Software: 10.3,
SubjectArea: "2015, 1511, 2217, 1330",
SubSecTimeDigitized: 245,
SubSecTimeOriginal: 245,
WhiteBalance: 0,
XResolution: "72/1",
YResolution: "72/1"
},
faces: [ ],
server: {
host: "ip-10-0-1-213",
ip: "10.0.1.213"
},
icc: {
copyright: "Copyright Apple Inc., 2016",
description: "Apple Wide Color Sharing Profile",
manufacturer: "Apple Wide Color Sharing Profile",
model: "Apple Wide Color Sharing Profile"
},
jpeg: {
colorspace: 2,
sampling-factor: "2x2,1x1,1x1"
}
}
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/imagizer_engine/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
