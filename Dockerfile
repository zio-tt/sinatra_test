# syntax=docker/dockerfile:1

# Dockerイメージとバージョンの指定
FROM ruby:3.1.4

# Rubyの実行に必要なパッケージのインストール
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev libsqlite3-dev nginx && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY Gemfile* /app/

RUN gem install bundler && bundle install

COPY . /app

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
