#!/bin/bash

# This bash script basically builds and destroys a series of vagrant boxes, using a different playbook for each.

TESTS=("$@")

if [ ${#TESTS[@]} -eq 0 ]; then
    cd tests
    TESTS=(*)
    cd ..
fi


for TEST_NAME in $TESTS ; do
  echo "*****************************"
  echo "*** $TEST_NAME..."
  echo "*****************************"
  cp "tests/$TEST_NAME" ./playbook.yml
  vagrant destroy --force &> /dev/null
  vagrant up --no-provision &> /dev/null
  vagrant provision
  rm ./playbook.yml
done