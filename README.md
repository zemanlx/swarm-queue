# Demo of RabbitMQ on Docker Swarm

- `publisher` - posts one message for `consumer-phase1` per 2s
- `consumer-phase1` - consumes messages from `publisher` it takes 5-10s to acknowlege and posts
  5-10 messages for `consumer-phase2`
- `consumer-phase2` - consumes messages from `consumer-phase1`, it takes 2-5s to acknowlege
