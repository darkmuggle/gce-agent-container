FROM centos/systemd

MAINTAINER "Ben Howard" <ben.howard@redhat.com>

RUN mkdir -p /etc/pki/rpm-gpg/
COPY install.sh /tmp
COPY gcloud-yum-key.gpg /etc/pki/rpm-gpg/

RUN bash -x /tmp/install.sh && \
    rpm --import /etc/pki/rpm-gpg/gcloud-yum-key.gpg && \
    rm -rf /tmp/*

RUN yum update -y && \
    yum install -y python-google-compute-engine google-compute-engine iproute

RUN systemctl disable google-accounts-daemon.service && \
    systemctl disable google-instance-setup.service && \
    systemctl disable google-shutdown-scripts.service && \
    systemctl disable google-shutdown-scripts.service && \
    systemctl disable console-getty

CMD ["/usr/sbin/init"]
