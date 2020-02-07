# syntax = docker/dockerfile:experimental

FROM elixir:1.10.0-alpine as builder

ARG tag="latest"

ENV TAG=${tag}

#RUN apk update && apk add make && rm -rf /var/cache/apk/*
RUN apk update && apk add openssh git bash && rm -rf /var/cache/apk

RUN git config  --global core.sshCommand "ssh -vvv"


COPY mix.lock . 
COPY mix.exs . 

RUN mkdir -p -m 0600 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts

RUN --mount=type=ssh MIX_ENV=prod mix do deps.get, deps.compile 

#RUN MIX_ENV=prod mix deps.get --only prod && MIX_ENV=prod mix do compile, phx.digest, release
#RUN MIX_ENV=prod mix deps.get --only prod && MIX_ENV=prod mix do compile, release
#
#FROM bitwalker/alpine-elixir:1.7.4 
#
#ARG tag="latest"
#
#ENV TAG=${tag}
#
#RUN apk update && apk add make && rm -rf /var/cache/apk/*
#
#COPY --from=builder \
#    /opt/app/_build/prod/rel/foo/releases/*/foo.tar.gz \
#    /opt/app/
#
#WORKDIR /opt/app
#
#RUN tar zxvfp ./foo.tar.gz && \
#    rm -rf ./foo.tar.gz && \
#    rm -rf ./.hex && \
#    rm -rf ./.mix 
#
#LABEL TAG="${TAG}" maintainer="binarytemple"
#
#ENTRYPOINT ["/opt/app/bin/foo"]
#
#CMD ["help"]
