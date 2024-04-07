#!/usr/bin/env bash

if [ -z "$1" ]; then
  echo "Need to pass output tag"
  exit 1
fi

mkdir -p "output/$1"

concurrencies=(1 2 4 6 8 12)
server="http://localhost:8080"

for concurrency in "${concurrencies[@]}"
do
  echo "Running '/' with $concurrency concurrency..."
  h2load --h1 --no-tls-proto=http/1.1 -D 30 "$server/" -t $concurrency -c $concurrency > "output/$1/$1-$concurrency.txt"
done

for concurrency in "${concurrencies[@]}"
do
  echo "Running '/user/:id' with $concurrency concurrency..."
  random=$[$RANDOM % 2048 + 1024]
  h2load --h1 --no-tls-proto=http/1.1 -D 30 "$server/user/$random" -t $concurrency -c $concurrency > "output/$1/$1-$concurrency-user-$random.txt"
done

for concurrency in "${concurrencies[@]}"
do
  # read in 10kb
  data="$(dd if=/dev/urandom bs=1k count=10)"
  echo $data > data.txt
  echo "Running '/user' with $concurrency concurrency..."
  random=$[$RANDOM % 2048 + 1024]
  h2load --h1 --no-tls-proto=http/1.1 -D 30 -d data.txt "$server/user" -t $concurrency -c $concurrency > "output/$1/$1-$concurrency-post-$random.txt"
  rm data.txt
done
