FROM python:alpine AS publisher
RUN pip install --user pika==0.11.2
RUN apk add --no-cache bind-tools=9.10.4_p8-r1
COPY scripts/ /
CMD while true; do \
      /publish.py \
        "from $(host $(hostname -i) | cut -d ' ' -f 5)" \
        "to $PUBLISHER_QUEUE_NAME" \
        "at $(date --utc +'%F--%H-%M-%S-%Z')"; \
      sleep $TASK_FREQUENCY; \
    done

FROM python:alpine AS publisher-consumer
RUN pip install --user pika==0.11.2
RUN apk add --no-cache bind-tools=9.10.4_p8-r1
COPY scripts/ /
CMD while true; do \
      /consumer.py; \
      for inc in $(seq 1 $TASK_GENERATED); do \
        /publish.py \
          "from $(host $(hostname -i) | cut -d ' ' -f 5)" \
          "to $PUBLISHER_QUEUE_NAME" \
          "at $(date --utc +'%F--%H-%M-%S-%Z')" \
          "$inc"; \
      done \
    done

FROM python:alpine AS consumer
RUN pip install --user pika==0.11.2
RUN apk add --no-cache bind-tools=9.10.4_p8-r1
COPY scripts/ /
CMD while true; do \
      /consumer.py; \
    done
