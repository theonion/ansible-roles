#!/bin/bash -e

# This bash script basically builds and destroys a series of vagrant boxes, using a different playbook for each.

TESTS=("$@")

if [ ${#TESTS[@]} -eq 0 ]; then
    cd tests
    TESTS=(*)
    cd ..
fi

log_test () {
    TEST_NAME=$1
    STARS=$((${#1} + 14))
    for i in $(eval echo "{1..$STARS}"); do
        echo -ne "*"
    done
    echo "*"
    echo "* Testing $1... *"
    for i in $(eval echo "{1..$STARS}"); do
        echo -ne "*"
    done
    echo "*"
}

for TEST_NAME in $TESTS ; do
  log_test $TEST_NAME
  cp "tests/$TEST_NAME" ./playbook.yml
  ansible-playbook --syntax-check -i vagrant_ansible_inventory_default playbook.yml
  vagrant destroy --force &> /dev/null
  vagrant up --no-provision &> /dev/null
  vagrant provision
  rm ./playbook.yml
done