# Require necessary libraries
require 'aws-sdk-s3'    # AWS SDK for S3
require 'pry'           # Debugging tool
require 'securerandom'  # For generating unique identifiers

# Fetch bucket name from environment variables
bucket_name = ENV['BUCKET_NAME']

# Define the AWS region
region = 'ap-south-1'

# Print the bucket name to the console
puts bucket_name

# Initialize the S3 client
client = Aws::S3::Client.new(region: region)

# Create a new S3 bucket
resp = client.create_bucket({
  bucket: bucket_name, 
  create_bucket_configuration: {
    location_constraint: region  # Specify the region for the bucket
  }
})

# binding.pry

# Generate a random number of files (between 1 and 6) to be created and uploaded
number_of_files = 1 + rand(6)
puts "number_of_files: #{number_of_files}"

# Ensure the /tmp directory exists
Dir.mkdir('/tmp') unless Dir.exist?('/tmp')

# Loop to create and upload each file
number_of_files.times.each do |i|
  # Print the current iteration number
  puts "i: #{i}"

  # Define the filename and output path
  filename = "file_#{i}.txt"
  output_path = "/tmp/#{filename}"

  # Create and write a random UUID to the file
  File.open(output_path, "w") do |f|
    f.write(SecureRandom.uuid)
  end

  # Open the file in binary read mode and upload it to S3
  File.open(output_path, 'rb') do |f|
    client.put_object(
      bucket: bucket_name,  # Specify the bucket name
      key: filename,        # Set the key (name) for the S3 object
      body: f               # Set the file content as the body of the S3 object
    )
  end
end
