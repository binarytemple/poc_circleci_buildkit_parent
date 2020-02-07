.EXPORT_ALL_VARIABLES:

DOCKER_BUILDKIT = 1

build:
	docker build --progress plain --ssh default=${SSH_AUTH_SOCK} .
