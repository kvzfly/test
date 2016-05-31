#!/bin/sh
cd ${WORKSPACE}/src
docker build -t 192.168.5.36:5002/poc/python-redis-demo:${BUILD_NUMBER} .

docker push 192.168.5.36:5002/poc/python-redis-demo:${BUILD_NUMBER}
cd ${WORKSPACE}/test-build

sed -i 's/\$\$BUILD_NUMBER\$\$/'${BUILD_NUMBER}'/g' docker-compose.yml
sed -i 's/\$\$PORT_NUMBER\$\$/'`expr 5000 + ${BUILD_NUMBER}`'/g' docker-compose.yml
chmod 777 ./rancher-compose

./rancher-compose --access-key 833795D1A9279F8A934E --secret-key QDs4JP1dHVdxRziCBC35RGxy1rrHSgh2TA1VkQwy -p python-redis-demo-build${BUILD_NUMBER} up -d
