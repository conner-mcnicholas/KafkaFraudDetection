printf 'collecting sample of fraudulent transactions for 25 seconds...'
./collect_fraud.sh;sleep 25;kill $"$(ps -aef | grep interactive | cut -f4 -d' ' | head -1)"
printf '\ndone!\n\n'

printf 'collecting sample of legitimate transactions for 25 seconds..'
./collect_legit.sh;sleep 25;kill $"$(ps -aef | grep interactive | cut -f4 -d' ' | head -1)"
printf '\ndone!\n\n'

ftot=$(wc -l fraud.out | cut -f1 -d' ')
echo '# fraudulent transactions = ' $ftot
ltot=$(wc -l legit.out | cut -f1 -d' ')
echo '# legitimate transactions = ' $ltot
fpct=$(echo "scale=2;100*$ftot/($ftot+$ltot)" | bc -l)
printf '\nyielding...\n'
echo 'transaction fraud rate = ' $fpct '%'
echo '(expecting ~ 10%)'
