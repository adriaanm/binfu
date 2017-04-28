#!/bin/bash
echo Updating to scala $1
curl -s http://downloads.typesafe.com/scala/$1/scala-$1.tgz | tar -xv -C ~/scala/ -f -
ln -sfh ~/scala/scala-$1 ~/scala/latest