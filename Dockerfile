from quay.io/jeroenmanders/infraxys-provisioning-server:ubuntu-base-18.04-latest

maintainer jeroen@manders.be

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y perl nmap python python-setuptools libunwind8 vim ruby-full \
    && add-apt-repository -y ppa:deadsnakes/ppa \
    && apt-get update \
    && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get install -y nodejs

RUN export DEBIAN_FRONTEND=noninteractive \
    && wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && apt-get update \
    && apt-get install -y powershell \
    && python /usr/lib/python2.7/dist-packages/easy_install.py pip \
    && pip install boto boto3 dop importlib httplib2 setuptools google-api-python-client argparse \
    && apt-add-repository ppa:ansible/ansible \
    && apt-get install -y ansible \
    && apt-get install -y python3-pip \
    && apt-get install -y -f \
    && apt-get install -y python3.7 \
    && python3.7 -m pip install -U marshmallow --pre \
    && python3.7 -m pip install -U pip \
    && python3.7 -m pip install -U hvac==0.7.2 \
    && python3.7 -m pip install -U requests \
    && python3.7 -m pip install -U boto3 \
    && python3.7 -m pip install -U kubernetes \
    && python3.7 -m pip install -U auth0-python

RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
    && echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list \
    && apt-get update \
    && apt-get install -y kubectl

# make sure there's no cd (change directory) in before the pip install line in this RUN command
RUN pip install awscli --upgrade --user \ 
    && mv ./root/.local/bin/aws /usr/local/bin

RUN apt-get install -y ca-certificates apt-transport-https lsb-release gnupg \
    && curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null \
    && AZ_REPO=$(lsb_release -cs) \
    && echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | tee /etc/apt/sources.list.d/azure-cli.list \
    && apt-get update \
    && apt-get install azure-cli

RUN curl -sL -o /tmp/vault.zip https://releases.hashicorp.com/vault/0.10.0/vault_0.10.0_linux_amd64.zip \
    && cd /tmp && unzip vault.zip && mv vault /usr/local/bin/ && rm -f vault.zip


VOLUME /infraxys
