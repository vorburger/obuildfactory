#!/bin/bash
#

export HG_TAGS=`hg tags | grep lambda | head -1 | sed "s/lambda//" | cut -d ' ' -f 1 | sed 's/^-//'`
export JVM_VERSION=`echo $HG_TAGS | sed "s/-/./g"`

echo "JVM_VERSION will be $JVM_VERSION"

if [ "$XBUILD" = "true" ]; then
  ./linux/build.sh

  if [ $? != 0 ]; then
    exit -1
  fi

fi

if [ "$XTEST" = "true" ]; then
  pushd linux
  ./test.sh

  if [ $? != 0 ]; then
    exit -1
  fi

  popd
fi

if [ "$XPACKAGE"  = "true" ]; then
  pushd linux
  ./package.sh

  if [ $? != 0 ]; then
    exit -1
  fi

  popd
fi