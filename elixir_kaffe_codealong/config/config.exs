config :kaffe,
consumer: [
  endpoints: [localhost: 9092],
  topics: ["our_topic", "another_topic"],     # the topic(s) that will be consumed
  consumer_group: "example-consumer-group",   # the consumer group for tracking offsets in Kafka
  message_handler: ExampleConsumer,           # the module that will process messages
]
