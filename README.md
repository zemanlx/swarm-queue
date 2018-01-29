# Demo of RabbitMQ on Docker

This repo is showing how RabbitMQ works. All is running in your docker so you
do not need to install anything but docker tools.

## Prerequisites
- Docker
- Docker Compose

## Run this Demo
1. Clone this repo
1. From repo folder run `docker-compose up`
1. Open rabbitmq [management](http://localhost:15672) interface (guest/guest)

## How it works

`ALL_CAPS` are environmet variables set in `docker-compose.yml` per each
_service_.

-   `publisher` - posts one message to `QUEUE_SERVER` to `PUBLISHER_QUEUE_NAME`
    every `TASK_FREQUENCY` seconds

-   `job-phase-1` - consumes messages from `CONSUMER_QUEUE_NAME`, it takes
    `TASK_DIFFICULTY` to acknowlege a message and posts `TASK_GENERATED` number
    of messages to `PUBLISHER_QUEUE_NAME`

-   `job-phase-2` - consumes messages from `CONSUMER_QUEUE_NAME`, it takes
    `TASK_DIFFICULTY` to acknowlege a message

![demo-1-architecture](https://user-images.githubusercontent.com/18702153/35512188-bdc18aca-04f6-11e8-8c37-0a99f0e87d7f.png)


## Play with scale

To have more fun with RabbitMQ you can tune environment variables in
`docker-compose.yml` and/or open another shell in this repo and scale each
service to give it a hard time.

```bash
docker-compose scale publisher=3
docker-compose scale job-phase-1=10
docker-compose scale job-phase-2=30
```

Sit back and enjoy logs from your first terminal and RabbitMQ Management Site.
There is a high probability that your queues will grow or you waste compute
resources so you can play scaling game as long as your have computer can handle
it.
