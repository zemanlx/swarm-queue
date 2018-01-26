FROM python:alpine AS publisher
RUN pip install --user pika==0.11.2
COPY publisher/publish.py /
CMD for inc in $(seq 1 1000); do ./publish.py $inc; sleep $(shuf -i 2-5 -n 1); done

FROM python:alpine AS consumer
RUN pip install --user pika==0.11.2
COPY consumer/consumer.py /
CMD while true; do /consumer.py; done
