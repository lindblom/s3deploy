require "s3deploy/version"
require "AWS/S3"
require "YAML"

class S3deploy

  AWS_REGIONS = %W(us-west-2 us-west-1 eu-west-1 ap-southeast-1 ap-northeast-1 sa-east-1)

  def initialize(options = {})
    defaults = { "path" => ".", "remote_path" => "" }
    @options = defaults.merge(options)
    @options.merge! import_settings(File.expand_path("~/.s3deploy/.s3deploy.yml"))
    @options.merge! import_settings(File.expand_path("./.s3deploy.yml"))

    puts @options
    raise "No AWS credentials given." unless @options["aws_key"] && @options["aws_secret"]

    set_aws_region(@options["aws_region"]) if @options["aws_region"]

    AWS::S3::Base.establish_connection!(
      :access_key_id     => @options["aws_key"],
      :secret_access_key => @options["aws_secret"]
    )

    puts "Will deploy to #{@options["aws_bucket"]}"
  end

  def deploy

    raise "No bucket selected." unless @options["aws_bucket"]
    bucket = AWS::S3::Bucket.find @options["aws_bucket"]

    path = File.expand_path(@options["path"])
    puts "path: #{path}"
    raise "#{@options["path"]} is not a path." unless File.directory? path

    files = all_files(path).map { |f| f.gsub(/^#{path}\//, "")}

    files.each do |file|
      full_path = (path + "/" + file).gsub( /\/\//, "/")
      full_remote_path = (@options["remote_path"] + "/" + file).gsub( /\/\//, "/").gsub( /(^\/)|(\/$)/, "")
      upload_file(full_path, full_remote_path)
    end

  end

  def upload_file(local, remote)
    AWS::S3::S3Object.store(remote, open(local), @options["aws_bucket"])
    puts "Uploading #{local} to #{remote}"
  end

  def self.install_config(default = false)
    install_path = default ? File.expand_path("~/.s3deploy/.s3deploy.yml") : File.expand_path("./.s3deploy.yml")

    raise "Configuration file already exist." if File.exist? install_path

    if default
      `mkdir -p #{File.dirname(install_path)}` unless File.directory? File.dirname(install_path)
    end

    puts `cp #{File.dirname(File.expand_path(__FILE__)) + "/.s3deploy.yml"} #{install_path}`

    puts "A configuration file has been created at #{install_path}"
  end

  def all_files(path = ".")
    files = []
    Dir.new(path).each do |row|
      next if %W{. .. .git}.include? row

      full_path = "#{path}/#{row}"

      if File.directory?(full_path)
        files |= all_files(full_path)
      else
        files << full_path
      end
    end
    files
  end
    
  def import_settings(file)
    settings = YAML::parse_file(file).to_ruby if File.file? file
    if settings && settings.class == Hash
      settings.delete_if { |k,v| k != "aws_region" && v.nil? }
    else
      Hash.new
    end
  end

  def set_aws_region(region)

    unless AWS_REGIONS.include? region.downcase
      raise "#{region} is not a valid region, please select from #{AWS_REGIONS.join(", ")} or leave it blank for US Standard." 
    end

    AWS::S3::DEFAULT_HOST.replace "s3-#{region}.amazonaws.com"

  end

end