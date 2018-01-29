FROM ruby:2.4.2

RUN apt-get update -qq && apt-get install -y  \
      build-essential     \
      curl                \
      git                 \
      libpq-dev           \
      nodejs              \
      vim                 \
      && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY Gemfile Gemfile.lock /app/
RUN gem install bundler && bundle install

COPY . .

