FROM alpine:3.10

LABEL version="0.0.1"
LABEL repository="https://github.com/advancedcsg-open/action-aws-sam"
LABEL homepage="https://github.com/advancedcsg-open/action-aws-sam"
LABEL maintainer="Advanced Toolchain"
LABEL "com.github.actions.name"="AWS SAM CLI"
LABEL "com.github.actions.description"="Run AWS SAM CLI commands"
LABEL "com.github.actions.icon"="check"
LABEL "com.github.actions.color"="green"

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)" \
    && test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv) \
    && test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv) \
    && test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile \
    && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile \
    && brew --version \
    && brew tap aws/tap \
    && brew install aws-sam-cli \
    && sam --version

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
