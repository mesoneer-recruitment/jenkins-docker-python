#---------
# Python Base
#---------
FROM python:3.8.12-alpine3.15 as ubitec_jenkins_python_base

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

#---------
# MkDocs
#---------
FROM ubitec_jenkins_python_base as ubitec_jenkins_mkdocs

LABEL name="jenknis-docker-mkdocs"
LABEL description="Docker image of MkDocs used for Jenkins pipeline.\
===\
mkdocs==1.1\
mkdocs-material==5.1.5\
"

RUN pip install mkdocs==1.1 mkdocs-material==5.1.5 pymdown-extensions==7.1

#---------
# Ansible
#---------
FROM ubitec_jenkins_python_base as ubitec_jenkins_ansible

LABEL name="jenknis-docker-ansible"
LABEL description="Docker image for using Ansible on Jenkins pipeline.\
===\
ansible==2.9.11\
"

RUN apk add --no-cache --virtual .build-deps \
    # These are the deps required for Ansible to be installed
    # successfully. They are installed in a virtual bundle
    # call .build-deps and they will be deleted later.
        libffi-dev openssl-dev make \
    && pip install ansible==2.9.11 boto3==1.20.20 \
    && apk del .build-deps \
    # Install OpenSSH Client & ssh-agent so that Jenkins Slaves
    # SSH can be used from within the Docker container.
    && apk add --no-cache \
        openssh \
    && rm -rf /var/cache/apk/*

# See https://stackoverflow.com/a/42216046/495558 for explanation.
# Basically, this overwrites the default shell /bin/sh
# and allows for activating the virtual environment.
SHELL ["/bin/bash", "-c"]
