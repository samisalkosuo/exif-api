FROM ruby:2.4.3

RUN apt-get update && \
    apt-get install -y net-tools exiftool

# Install gems
ENV APP_HOME /app
ENV HOME /root
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
COPY src/Gemfile* $APP_HOME/
RUN gem install bundler && bundle install --jobs 20 --retry 5

# Upload source
COPY ./src/ $APP_HOME

# Start server
EXPOSE 3000

CMD ["bundle", "exec", "rackup"]