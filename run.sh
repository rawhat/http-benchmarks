#!/usr/bin/env bash

if [ -z "$1" ]; then
  echo "Need to pass output tag"
  exit 1
fi

mkdir -p "output/$1"

concurrencies=(1 2 4 6 8 12 16)

for concurrency in "${concurrencies[@]}"
do
  echo "Running '/' with $concurrency concurrency..."
  ab -n 200000 -l -c $concurrency http://localhost:8080/ > "output/$1/$1-$concurrency.txt"
done

for concurrency in "${concurrencies[@]}"
do
  echo "Running '/user/:id' with $concurrency concurrency..."
  random=$[$RANDOM % 2048 + 1024]
  ab -n 200000 -l -c $concurrency "http://localhost:8080/user/$random" > "output/$1/$1-$concurrency-user-$random.txt"
done

for concurrency in "${concurrencies[@]}"
do
  # read in 1kb
  data="$(dd if=/dev/urandom bs=1 count=1024)"
  echo $data > data.txt
  echo "Running '/user/:id' with $concurrency concurrency..."
  random=$[$RANDOM % 2048 + 1024]
  ab -n 200000 -l -c $concurrency -p data.txt "http://localhost:8080/user" > "output/$1/$1-$concurrency-post-$random.txt"
  rm data.txt
done
