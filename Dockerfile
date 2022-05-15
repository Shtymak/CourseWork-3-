FROM ruby:2.7.3
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN gem install bundler
RUN bundle --version
RUN bundle install
EXPOSE 3000
COPY . /app

CMD ["rails", "server", "-b", "0.0.0.0"]