FROM registry.fedoraproject.org/fedora:latest
RUN dnf install -y tar which python3 python3-pip\
    libselinux-python3 python-argcomplete\
    openldap-devel python3-devel python3-tox vim rsync tmux ShellCheck\
    lcov svn git nodejs nodejs-yarn net-tools sudo bash-completion fish zsh jq&&\
    dnf groupinstall "Development Tools" -y &&\
    activate-global-python-argcomplete &&\
    mkdir /wheels && chmod 0777 /wheels

COPY requirements.txt .
RUN pip3 install -r requirements.txt


