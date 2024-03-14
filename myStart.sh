#!/bin/bash
cd ../fabric-samples/test-network
./network.sh up createChannel -s couchdb
cd prometheus-grafana
docker-compose up -d
cd ..
./network.sh deployCC -ccn fixed-asset -ccp ../../caliper-benchmarks/src/fabric/api/fixed-asset/go -ccl go -cccg ../../caliper-benchmarks/src/fabric/api/fixed-asset/collections-config.json
cd ../../caliper-benchmarks
npx caliper launch manager --caliper-workspace ./ --caliper-networkconfig networks/fabric/test-network.yaml --caliper-benchconfig benchmarks/api/fabric/test.yaml --caliper-flow-only-test --caliper-fabric-gateway-enabled
cd ../fabric-samples/test-network/prometheus-grafana
docker-compose down
cd ..
./network.sh down