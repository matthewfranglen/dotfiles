FROM python

RUN apt-get update
RUN apt-get install -y zsh git curl

COPY ./script/test /test

CMD ["/test"]
