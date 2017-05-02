FROM python

RUN apt-get update
RUN apt-get install -y zsh git curl

CMD ["bash"]
