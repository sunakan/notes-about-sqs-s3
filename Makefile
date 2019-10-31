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
