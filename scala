#!/bin/sh

if [ -z ${SCALA_HOME+x} ]; then
    echo ERROR: SCALA_HOME is not set
    exit 1
fi

if ! [ -x "$(command -v winpty)" ]; then
  export WINPTYCMD=
else
  export WINPTYCMD=winpty
fi

if [ "$OSTYPE" = "msys" ]; then  
    export SCALACMD=scala.bat
else
    export SCALACMD=scala
fi

if [ -f $SCALA_HOME/bin/$SCALACMD ]; then
    $WINPTYCMD $SCALA_HOME/bin/$SCALACMD $*
else
    $WINPTYCMD sbt-scala.cmd $*
fi