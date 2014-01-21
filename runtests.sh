#!/bin/bash -e

# This bash script basically builds and destroys a series of vagrant boxes, using a different playbook for each.

TESTS=("$@")

if [ ${#TESTS[@]} -eq 0 ]; then
    cd tests/playbooks
    TESTS=(*)
    cd ../..
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
  cp "tests/playbooks/$TEST_NAME" ./playbook.yml
  if [ -e vagrant_ansible_inventory_default ]
  then 
    ansible-playbook --syntax-check -i vagrant_ansible_inventory_default playbook.yml
  fi

  vagrant destroy --force &> /dev/null
  vagrant up --no-provision &> /dev/null
  vagrant provision
  rm ./playbook.yml
done