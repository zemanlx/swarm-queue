#!/usr/bin/env python
import pika
import time
import os


def callback(ch, method, properties, body):
    print(" [x] Received %s" % (body))
    time.sleep(int(os.environ['TASK_DIFFICULTY']))
    print(" [x] Done")
    ch.basic_ack(delivery_tag=method.delivery_tag)
    connection.close()


connection = pika.BlockingConnection(pika.ConnectionParameters(
    host=os.environ['QUEUE_SERVER'], connection_attempts=5, retry_delay=5))
channel = connection.channel()

channel.queue_declare(queue=os.environ['CONSUMER_QUEUE_NAME'], durable=True)

channel.basic_qos(prefetch_count=1)
channel.basic_consume(callback, queue=os.environ['CONSUMER_QUEUE_NAME'])

channel.start_consuming()
