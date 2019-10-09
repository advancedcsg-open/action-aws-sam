FROM python:3-alpine

LABEL version="0.0.2"
LABEL repository="https://github.com/advancedcsg-open/action-aws-sam"
LABEL homepage="https://github.com/advancedcsg-open/action-aws-sam"
LABEL maintainer="Advanced Toolchain"
LABEL "com.github.actions.name"="AWS SAM CLI"
LABEL "com.github.actions.description"="Run AWS SAM CLI commands"
LABEL "com.github.actions.icon"="check"
LABEL "com.github.actions.color"="green"

ENV DOCKERVERSION=18.06.1-ce
RUN apk update && \
  apk add curl groff jq bash build-base curl file git gzip libc6-compat ncurses && \
  curl -fsSLO https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v0.3.0/heptio-authenticator-aws_0.3.0_linux_amd64 && \
  mv heptio-authenticator-aws_0.3.0_linux_amd64 /usr/local/bin/aws-iam-authenticator && \
  chmod +x /usr/local/bin/aws-iam-authenticator && \
  curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKERVERSION}.tgz && \
  tar xzvf docker-${DOCKERVERSION}.tgz --strip 1 \
                 -C /usr/local/bin docker/docker && \
  rm docker-${DOCKERVERSION}.tgz && \
  rm -rf /var/lib/apt/lists/* && \
  pip install --upgrade pip && \
  pip install setuptools awscli aws-sam-cli

COPY "entrypoint.sh" "/entrypoint.sh"
ENTRYPOINT ["/entrypoint.sh"]
