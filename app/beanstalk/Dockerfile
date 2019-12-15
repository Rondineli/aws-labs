FROM amazonlinux
MAINTAINER Rondineli Gomes <rdearaujo@fender.com>

USER root

RUN yum install python3-pip which python3 python3-setuptools python3-dev gcc git libffi musl-dev libffi-dev openssh-client postgresql-dev py3-virtualenv jq curl -y

RUN pip3 install -U virtualenv pipenv pip enum34

VOLUME /var/task

WORKDIR /var/task

ADD . /var/task/

RUN pipenv install 

EXPOSE 5000

CMD ["pipenv", "run", "python3", "./app.py"]
