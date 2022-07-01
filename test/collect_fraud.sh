docker-compose -f ../docker-compose.kafka.yml exec -T broker kafka-console-consumer --bootstrap-server localhost:9092 --topic streaming.transactions.fraud > fraud.out &
