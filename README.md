# KafkaFraudDetection

I needed to clear the docker cache out because of error in transactions.py transferred using copy/paste<br>
  -Python failed with: 'Invalid characer in identifier" due to incompatible doubles quote (") ascii char<br>
  -Even after modifying transactions.py to use the correct char, it still failed from the same error.<br>
  -Realized it wasn't even picking up the modification after updating the code to use "GBR" instead of "USD":<br>

![alt text](https://github.com/conner-mcnicholas/KafkaFraudDetection/blob/main/imgs/cacheerror.png?raw=true)

To clear the cache out required removal of containers/images that are no longer running.<br>
Created aliases in .bashrc for ease of use:<br>
`alias docker_clean_ps='docker rm $(docker ps -a -q)'`<br>
`alias docker_clean_im='docker rmi $(docker images -a -q)'`<br>

To compare the output from the fraudulent and legitimate transaction stream output over the same time duration<br>
  -start kafka-consumer with pseudo-TTY allocation disabled with '-T, --no-TTY' option on docker exec command<br>
  -redirect stdout to file on local filesystem<br>
  -send process to the background<br>
  -sleep for prescribed duration<br>
  -find and kill the PID of the bg kafka-consumer process<br>
  -count number of messages in each stream stdout file<br>
<br>
This exercise can be replicated using:<br>
`./test/run.sh > report.out`<br>

![alt text](https://github.com/conner-mcnicholas/KafkaFraudDetection/blob/main/imgs/simulation.png?raw=true)
