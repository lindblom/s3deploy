# S3deploy

S3deploy is a tool for deploying static websites to Amazon S3.

**Attention!** I am no longer maintaining this project. So if you want it, it can be yours. :)

## Installation

Add this line to your application's Gemfile:

    gem 's3deploy'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install s3deploy

## Usage

Get an Amazon AWS account and create the bucket you want to use. Set up the bucket to be used as a website.

### Create configuration files

Create a folder configuration file like this:

    $ s3deploy init

Then update the newly created .s3deploy.yml with your settings (comments in the generated file explains how to set it).
You might want to create a default configuration file where you can store information shared between sites, like Amazon access key, secret and region. You do that with this command:

    $ s3deploy init --default

This configuration file will be created in your home directory in the .s3deploy folder. Update this file with your info, remember that the settings in the .s3deploy.yml in the project folder takes precedance over settings in this file.

### Deployment

Deploying is easy now, just type:

    $ s3deploy

If you want to test-drive your configuration you can simulate a deploy

    $ s3deploy simulate

### Other

If you want to empty a bucket, you can do it with this command:

    $ s3deploy empty

But beware that all files will be removed, you can simulate emptying the bucket with:

    $ s3deploy simulate empty

## Whats next?

1. Create method for creating a bucket from the settings in the configuration and settings it up as a website.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
