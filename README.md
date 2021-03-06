# KafkaFraudDetection

## Building A Streaming Fraud Detection System With Kafka, Python, and Docker

This application generates a stream of transactions and processes them to detect which ones are potential fraud.<br>
Fake transactions are generated on one end with a transaction generator, then filtered for suspicious activity<br>
the other end with a fraud detector. (Because this is intended to be instructive as a Kafka exercise and not financial compliance<br>
regulations, fraudulent activity is defined by a price treshold > $900 given randomly generated prices between $0-$1000.)<br>
Both applications will run in Docker containers and interact with the Kafka cluster.<br>
<br>
Block diagram of the fraud detection system:<br>

![alt text](https://github.com/conner-mcnicholas/KafkaFraudDetection/blob/main/imgs/blockdiagram.png?raw=true)

<br>

### To Run:

From terminal in project base directory,<br>
 `docker-compose -f docker-compose.kafka.yml up`<br>
Leave running, then from new terminal session:<br>
`docker-compose up`<br>
Leave running, then from new terminal session:<br>
`cd test`<br>
`./run.sh > report.out`<br>

![alt text](https://github.com/conner-mcnicholas/KafkaFraudDetection/blob/main/imgs/simulation.png?raw=true)

<br>

### Lessons Learned:

I needed to clear the docker cache out because of error in transactions.py transferred using copy/paste<br>
&emsp;&emsp;&emsp;&emsp;-Python failed with: 'Invalid characer in identifier" due to incompatible doubles quote (") ascii char<br>
&emsp;&emsp;&emsp;&emsp;-Even after modifying transactions.py to use the correct char, it still failed from the same error.<br>
&emsp;&emsp;&emsp;&emsp;-Realized it wasn't even picking up the modification after updating the code to use "GBR" instead of "USD":<br>

![alt text](https://github.com/conner-mcnicholas/KafkaFraudDetection/blob/main/imgs/cacheerror.png?raw=true)

To clear the cache out required removal of containers/images that are no longer running.<br>
&emsp;&emsp;&emsp;&emsp;-Created aliases in .bashrc for ease of use:<br>
`alias docker_clean_ps='docker rm $(docker ps -a -q)'`<br>
`alias docker_clean_im='docker rmi $(docker images -a -q)'`<br>

To compare the output from the fraudulent and legitimate transaction stream output over the same time duration<br>
&emsp;&emsp;&emsp;&emsp;-start kafka-consumer with pseudo-TTY allocation disabled with '-T' option on docker exec command<br>
&emsp;&emsp;&emsp;&emsp;-redirect stdout to file on local filesystem<br>
&emsp;&emsp;&emsp;&emsp;-send process to the background<br>
&emsp;&emsp;&emsp;&emsp;-sleep for prescribed duration<br>
&emsp;&emsp;&emsp;&emsp;-find and kill the PID of the bg kafka-consumer process<br>
&emsp;&emsp;&emsp;&emsp;-count number of messages in each stream stdout file<br>
