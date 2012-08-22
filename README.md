# S3deploy

S3deploy is a tool for deploying static websites to Amazon S3.

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

Then update the newly created .s3deploy.yml with your settings.
You might want to create a default configuration file where you can store information shared between sites, like Amazon access key, secret and region. You do that with this command:

    $ s3deploy init --default
  
This configuration file will be created in your home directory in the .s3deploy folder. Update this file with your info, remember that the settings in the .s3deploy.yml in the project folder takes precedance over settings in this file.

### Deployment

Deploying is easy now, just type:

    $ s3deploy

If you want to test-drive your configuration you can simulate a deploy

    $ s3deploy simulate

## Whats in the pipe-line
1. Setting caching-headers by regex
2. Skipping files by regex
3. Putting it on github for others to contribute

## Contributing
(you cant do this riktigt now, but it will be on the githubz soon)

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
