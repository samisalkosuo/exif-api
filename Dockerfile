FROM ruby:2.7.1-alpine3.11

RUN apk add --no-cache exiftool

# Create user and change workdir
RUN adduser --disabled-password --home /home/exifapi exifapi
WORKDIR /home/exifapi

# Install gems
COPY src/Gemfile* .
RUN gem install bundler && bundle install --jobs 20 --retry 5

# Copy docs
COPY ./docs/ ./docs/

# Copy sources
COPY ./src/ .

EXPOSE 3000

# Change user
USER exifapi

# Start server
CMD ["bundle", "exec", "rackup"]
