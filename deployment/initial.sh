#!/bin/bash

cp -Rv ./deployment/* ${1:-../../}
# often needed
# npm install
# but we have all js dependencies in the source tree
cd ${1:-../../}
mv redeploy.settings.dist redeploy.settings
git clone https://github.com/acdh-oeaw/zuludict-data
if [ "${STACK}x" = "x" ]; then
pushd lib/custom
curl -LO https://repo1.maven.org/maven2/net/sf/saxon/Saxon-HE/10.6/Saxon-HE-10.6.jar
popd
if [ "$OSTYPE" == "msys" -o "$OSTYPE" == "win32" ]
then
  cd bin
  start basexhttp.bat
else
  cd bin
  ./basexhttp &
fi
cd ..
fi
exec ./redeploy.sh