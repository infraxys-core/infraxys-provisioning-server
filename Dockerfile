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

RUN curl -L -o /tmp/helm.tar.gz https://storage.googleapis.com/kubernetes-helm/helm-v2.6.1-linux-amd64.tar.gz \
    && cd /tmp && tar -zxvf helm.tar.gz && rm -f helm.tar.gz && mv linux-amd64/helm /usr/local/bin/helm-v2.6.1 \
    && curl -L -o /tmp/helm.tar.gz https://storage.googleapis.com/kubernetes-helm/helm-v2.6.2-linux-amd64.tar.gz \
    && cd /tmp && tar -zxvf helm.tar.gz && rm -f helm.tar.gz && mv linux-amd64/helm /usr/local/bin/helm-v2.6.2 \
    && curl -L -o /tmp/helm.tar.gz https://storage.googleapis.com/kubernetes-helm/helm-v2.11.0-linux-amd64.tar.gz \
    && cd /tmp && tar -zxvf helm.tar.gz && rm -f helm.tar.gz && mv linux-amd64/helm /usr/local/bin/helm-v2.11.0 \
    && curl -L -o /tmp/helm.tar.gz https://storage.googleapis.com/kubernetes-helm/helm-v2.12.1-linux-amd64.tar.gz \
    && cd /tmp && tar -zxvf helm.tar.gz && rm -f helm.tar.gz && mv linux-amd64/helm /usr/local/bin/helm-v2.12.1 \
    && curl -L -o /tmp/helm.tar.gz https://storage.googleapis.com/kubernetes-helm/helm-v2.14.1-linux-amd64.tar.gz \
    && cd /tmp && tar -zxvf helm.tar.gz && rm -f helm.tar.gz && mv linux-amd64/helm /usr/local/bin/helm-v2.14.1

RUN curl -L -o /tmp/vault.zip https://releases.hashicorp.com/vault/0.10.0/vault_0.10.0_linux_amd64.zip \
    && cd /tmp && unzip vault.zip && mv vault /usr/local/bin/ && rm -f vault.zip
#    && curl -L -o /tmp/vault.zip https://releases.hashicorp.com/vault/1.1.3/vault_1.1.3_linux_amd64.zip \
#    && cd /tmp && unzip vault.zip && mv vault /usr/local/bin/ && rm -f vault.zip

RUN curl -L -o /tmp/terraform.zip https://releases.hashicorp.com/terraform/0.9.11/terraform_0.9.11_linux_amd64.zip \
    && cd /tmp && unzip terraform.zip && mv terraform /usr/local/bin/terraform-0.9.11 && rm -f terraform.zip \
    && curl -L -o /tmp/terraform.zip https://releases.hashicorp.com/terraform/0.10.6/terraform_0.10.6_linux_amd64.zip \
    && cd /tmp && unzip terraform.zip && mv terraform /usr/local/bin/terraform-0.10.6 && rm -f terraform.zip \
    && curl -L -o /tmp/terraform.zip https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip \
    && cd /tmp && unzip terraform.zip && mv terraform /usr/local/bin/terraform-0.11.7 && rm -f terraform.zip \
    && curl -L -o /tmp/terraform.zip https://releases.hashicorp.com/terraform/0.11.10/terraform_0.11.10_linux_amd64.zip \
    && cd /tmp && unzip terraform.zip && mv terraform /usr/local/bin/terraform-0.11.10 && rm -f terraform.zip \
    && curl -L -o /tmp/terraform.zip https://releases.hashicorp.com/terraform/0.11.11/terraform_0.11.11_linux_amd64.zip \
    && cd /tmp && unzip terraform.zip && mv terraform /usr/local/bin/terraform-0.11.11 && rm -f terraform.zip

RUN curl -L -o /tmp/packer.zip https://releases.hashicorp.com/packer/0.12.3/packer_0.12.3_linux_amd64.zip \
    && cd /tmp && unzip packer.zip && mv packer /usr/local/bin/packer-0.12.3 && rm -f packer.zip \
    && curl -L -o /tmp/packer.zip https://releases.hashicorp.com/packer/1.3.1/packer_1.3.1_linux_amd64.zip \
    && cd /tmp && unzip packer.zip && mv packer /usr/local/bin/packer-1.3.1 && rm -f packer.zip \
    && curl -L -o /tmp/packer.zip https://releases.hashicorp.com/packer/1.4.1/packer_1.4.1_linux_amd64.zip \
    && cd /tmp && unzip packer.zip && mv packer /usr/local/bin/packer-1.4.1 && rm -f packer.zip

VOLUME /infraxys
