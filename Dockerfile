FROM octohost/python:2.7.6

RUN mkdir /srv/www

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv-keys C300EE8C; \
  echo 'deb http://ppa.launchpad.net/nginx/stable/ubuntu trusty main' > /etc/apt/sources.list.d/nginx-stable-trusty.list; \
  apt-get update && apt-get install -y nginx && apt-get clean; \
  rm -rf /var/lib/apt/lists/*

RUN pip install gunicorn

ADD default /etc/nginx/sites-available/default
ADD nginx.conf /etc/nginx/nginx.conf

ADD . /srv/www

WORKDIR /srv/www

RUN pip install -r requirements.txt

EXPOSE 80

CMD gunicorn -D -b 0.0.0.0:5000 --workers=2 --log-level=debug hello:app && nginx
