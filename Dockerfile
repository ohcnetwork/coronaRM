# Dockerfile

# Use ruby image to build our own image
FROM ruby:2.7.0

# We specify everything will happen within the /app folder inside the container
WORKDIR /app

# We copy these files from our current application to the /app container
COPY Gemfile Gemfile.lock ./

# We install all the dependencies
RUN bundle install

# We copy all the files from our current application to the /app container
COPY . .

# We expose the port
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]