FROM ruby:2.6.5

ENV APP_ROOT /app_name
ENV DB_HOST db
WORKDIR $APP_ROOT

RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN gem install bundler
COPY Gemfile $APP_ROOT
COPY Gemfile.lock $APP_ROOT

RUN \
  echo 'gem: --no-document' >> ~/.gemrc && \
  cp ~/.gemrc /etc/gemrc && \
  chmod ugo+r /etc/gemrc && \
  bundle config --global jobs 4 && \
	bundle config set without 'production' && \
  bundle install && \
  rm -rf ~/.gem

COPY . $APP_ROOT

EXPOSE 3000