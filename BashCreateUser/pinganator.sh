#!/bin/bash

url="$1"
retries="$2"

counter=1

echo "==============================">> ping_output.txt
echo "start ping to $url $retries times" >> ping_output.txt
ping -c 1 $url

while [ $counter -le $retries ]
do
    ping -c 1 $url >> ping_output.txt
    ((counter++))
done

echo "==============================">> ping_output.txt

echo $url
echo $retries