FROM ruby:2.4

# basic dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

# Install capybara-webkit deps
RUN apt-get update \
    && apt-get install -y xvfb qt5-default libqt5webkit5-dev \
                          gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x

# Node.js
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash - \
    && apt-get install -y nodejs

# selenium
RUN apt-get install -y python-pip
RUN pip install selenium

# Chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome-stable_current_amd64.deb; apt-get -fy install

RUN mkdir /docker_test
WORKDIR /docker_test
ADD Gemfile /docker_test/Gemfile
ADD Gemfile.lock /docker_test/Gemfile.lock
RUN bundle install
ADD . /docker_test