FROM python:3.8.0-alpine3.10 as ubitec_jenkins_python_base

LABEL name="jenkins-docker-python"
LABEL version="SHOULD_BE_SPECIFIED"
LABEL owner="ubitec"
LABEL maintainer="developers@ubitec.com"
LABEL description="Docker image of Python used for Jenkins pipeline."

RUN apk add --no-cache --update \
	&& apk add gcc musl-dev linux-headers \
	&& rm -rf /var/cache/apk/*

RUN addgroup -g 3000 jenkins \
	&& adduser -D -g GECOS -G jenkins -u 3000 jenkins

FROM ubitec_jenkins_python_base as ubitec_jenkins_mkdocs

LABEL name="jenknis-docker-mkdocs"
LABEL description="Docker image of MkDocs used for Jenkins pipeline.\
===\
mkdocs==1.1\
mkdocs-material==5.1.5\
"

RUN pip install --user mkdocs==1.1 mkdocs-material==5.1.5 \
	&& export PATH=$PATH:~jenkins/.local/bin
