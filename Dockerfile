# syntax = docker/dockerfile:experimental

FROM elixir:1.10.0-alpine as builder

ARG tag="latest"

ENV TAG=${tag}

RUN apk update && apk add openssh git bash && rm -rf /var/cache/apk

# in case of weird ssh issues - re-enable for verbose git/ssh logging.
# RUN git config  --global core.sshCommand "ssh -vvv"

WORKDIR /opt/app

COPY mix.lock . 
COPY mix.exs . 

RUN mkdir -p -m 0600 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts

RUN --mount=type=ssh mix do deps.get, deps.compile 

COPY lib lib

RUN mix compile 

COPY test test 

RUN MIX_ENV=test mix do deps.get, test

COPY priv priv 

COPY rel rel 

RUN MIX_ENV=prod mix release 

FROM elixir:1.10.4-alpine AS release

RUN apk update --no-cache && apk add --no-cache bind-tools

WORKDIR /opt/app

COPY --from=builder \
  /opt/app/_build/prod/rel .
  #/opt/app/_build/prod/rel/poc_circleci_buildkit_parent/* .
 
#RUN find /opt/app 
   
ENTRYPOINT ["/opt/app/poc_circleci_buildkit_parent/bin/poc_circleci_buildkit_parent"]

CMD ["start_iex"]
