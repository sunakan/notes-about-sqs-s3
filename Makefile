ci:
	circleci config process .circleci/config.yml > .circleci/config-2.0.yml
	circleci local execute -c .circleci/config-2.0.yml --job helloworld
	circleci local execute -c .circleci/config-2.0.yml --job gradle-java-junit

ci-valid:
	circleci config validate

setup-shared-env:
	cp ./profiles/env.shared ./.env
setup-java-gradle: setup-shared-env
	cat ./profiles/java-gradle/env >> ./.env

config:
	docker-compose config

up:
	docker-compose up -d
down:
	docker-compose down

bash:
	docker-compose exec app bash

ENDPOINT=http://sqs:9324
QUEUE_NAME=suna--dev
q-list:
	docker-compose -f docker-compose.aws-cli.yml -f docker-compose.network.yml run --rm aws-cli \
    sqs list-queues \
    --endpoint-url ${ENDPOINT}

q-size:
	docker-compose -f docker-compose.aws-cli.yml -f docker-compose.network.yml run --rm aws-cli \
    sqs get-queue-attributes \
    --endpoint-url ${ENDPOINT} \
    --queue-url http://fake-sqs:9324/queue/${QUEUE_NAME} \
    --attribute-names ApproximateNumberOfMessages \
      ApproximateNumberOfMessagesDelayed \
      ApproximateNumberOfMessagesNotVisible

enq:
	docker-compose -f docker-compose.aws-cli.yml -f docker-compose.network.yml run --rm aws-cli \
    sqs send-message \
    --queue-url http://fake-sqs:9324/queue/${QUEUE_NAME} \
    --endpoint-url ${ENDPOINT} \
    --message-body "helloworld"
