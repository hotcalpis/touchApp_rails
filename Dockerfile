FROM ruby:2.6.5

ENV APP_ROOT /app_name
ENV DB_HOST db
WORKDIR $APP_ROOT

RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs qt5-default libqt5webkit5-dev gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN gem install bundler
COPY Gemfile $APP_ROOT
COPY Gemfile.lock $APP_ROOT

RUN \
  echo 'gem: --no-document' >> ~/.gemrc && \
  cp ~/.gemrc /etc/gemrc && \
  chmod ugo+r /etc/gemrc && \
  bundle config --global jobs 4 && \
  bundle install && \
  rm -rf ~/.gem

COPY . $APP_ROOT

#RUN chmod 644 /etc/mysql/conf.d/default_authentication.cnf   ###自動でdefault_authentication_pluginをmysql_native_passwordにしたい。が、windowsの権限システムが邪魔して？出来ないのでとりあえず手動でMySQL内部から変更

EXPOSE 3000