.EXPORT_ALL_VARIABLES:



build:
	DOCKER_BUILDKIT=1 docker build --progress plain --ssh default=${SSH_AUTH_SOCK} -t foo .
