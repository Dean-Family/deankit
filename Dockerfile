FROM quay.io/fedora/fedora:33-x86_64

ARG username="gdean"
ARG shell="usr/bin/fish"
ARG home="/home/${username}"

ENV SHELL=${shell}
RUN dnf install -y tar which python3 python3-pip\
    libselinux-python3 python-argcomplete\
    openldap-devel python3-devel python3-tox vim rsync tmux ShellCheck\
    lcov svn git nodejs nodejs-yarn net-tools sudo bash-completion fish zsh jq&&\
    dnf groupinstall "Development Tools" -y

RUN activate-global-python-argcomplete

RUN useradd -u 1000 --create-home ${username} &&\
    echo "${username} ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/${username} &&\
    mkdir /cache

USER ${username}
WORKDIR ${home}

RUN mkdir "${home}/.config"