ci:
	circleci config process .circleci/config.yml > .circleci/config-2.0.yml
	circleci local execute -c .circleci/config-2.0.yml --job helloworld
	circleci local execute -c .circleci/config-2.0.yml --job gradle-java-junit

ci-valid:
	circleci config validate

up-java-gradle:
	cp ./profiles/java-gradle/env ./.env
	docker-compose up -d

bash-java-gradle:
	docker-compose exec java-gradle bash
