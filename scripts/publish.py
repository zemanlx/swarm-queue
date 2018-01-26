#!/usr/bin/env python
import pika
import sys
import os

connection = pika.BlockingConnection(pika.ConnectionParameters(
    host=os.environ['QUEUE_SERVER'], connection_attempts=5, retry_delay=5))
channel = connection.channel()

channel.queue_declare(queue=os.environ['PUBLISHER_QUEUE_NAME'], durable=True)

message = ' '.join(sys.argv[1:]) or "Hello World!"
channel.basic_publish(exchange='',
                      routing_key=os.environ['PUBLISHER_QUEUE_NAME'],
                      body=message,
                      properties=pika.BasicProperties(
                         delivery_mode=2,  # make message persistent
                      ))
print(" [x] Sent %r" % message)
connection.close()
