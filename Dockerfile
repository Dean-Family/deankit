FROM quay.io/fedora/fedora:33-x86_64

ARG username="gdean"
ARG shell="/usr/bin/fish"
ARG home="/home/${username}"

RUN dnf install -y tar which python3 python3-pip\
    libselinux-python3 python-argcomplete\
    openldap-devel python3-devel python3-tox vim rsync tmux ShellCheck\
    lcov svn git nodejs yarnpkg  net-tools sudo bash-completion fish zsh jq&&\
    dnf groupinstall "Development Tools" -y

RUN activate-global-python-argcomplete

RUN useradd -u 1000 --create-home ${username} --shell "${shell}" &&\
    echo "${username} ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/${username} &&\
    mkdir /cache

USER ${username}
ENV SHELL=${shell}
WORKDIR ${home}

RUN git clone https://github.com/Dean-Family/dotfiles.git
RUN ln -sfn dotfiles/.config .config
RUN ln -sfn .config/vim/vimrc .vimrc