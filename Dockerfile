FROM python:3.8.0-alpine3.10

LABEL owner="ubitec"
LABEL maintainer="developers@ubitec.com"
LABEL description="Docker image of Python used for Jenkins pipeline."

RUN apk add --no-cache --update \
	&& rm -rf /var/cache/apk/*

RUN addgroup -g 3000 jenkins \
	&& adduser -D -g GECOS -G jenkins -u 3000 jenkins

# See https://stackoverflow.com/a/42216046/495558 for explanation.
# Basically, this overwrites the default shell /bin/sh
# and allows for activating the virtual environment.

SHELL ["/bin/bash", "-c"]
