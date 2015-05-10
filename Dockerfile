FROM octohost/python:2.7.6

RUN mkdir /srv/www

ADD . /srv/www

WORKDIR /srv/www

RUN pip install -r requirements.txt

EXPOSE 5000

CMD python hello.py
