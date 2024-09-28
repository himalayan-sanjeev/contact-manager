# Use an official Ruby runtime as a parent image
FROM ruby:3.0.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Set the working directory
WORKDIR /app

# Copy the Gemfile and Gemfile.lock into the image
COPY Gemfile Gemfile.lock /app/

# Install gems
RUN gem install bundler:2.2.33
RUN bundle install

# Copy the rest of the app
COPY . /app

# Precompile assets if required (Uncomment if needed)
# RUN bundle exec rake assets:precompile

# Expose the port the app runs on
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
