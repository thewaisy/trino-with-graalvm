FROM ubuntu:20.04

ARG TRINO_VERSION=372

LABEL author="waisy" email="thewaisy@gmail.com"
LABEL trino_version=${PRESTO_VERSION}


ARG GRAALVM_VERSION=22.0.0.2
ARG PYTHON_VERSION=3.8.12


# SET ENV
ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/opt/graalvm/bin:$PATH"
ENV JAVA_HOME="/opt/graalvm"
ENV PATH="/opt/trino/bin:$PATH"
# Set the URL to download
ENV TRINO_URL=https://repo1.maven.org/maven2/io/trino/trino-server/${TRINO_VERSION}/trino-server-${TRINO_VERSION}.tar.gz


# Update the base image OS and install wget and python
# openjdk-11-jdk not require
RUN apt-get update && \
    apt-get install -y build-essential \
        wget \
        libz-dev \
        zlib1g-dev \
        less


# Install GraalVM 
RUN wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-${GRAALVM_VERSION}/graalvm-ce-java11-linux-aarch64-${GRAALVM_VERSION}.tar.gz \
        -O /opt/graalvm-ce-java11-linux-aarch64-${GRAALVM_VERSION}.tar.gz && \
    mkdir -p /opt/graalvm && \
    tar -xzf /opt/graalvm-ce-java11-linux-aarch64-${GRAALVM_VERSION}.tar.gz \
        -C /opt/graalvm --strip-components 1 && \
    rm /opt/graalvm-ce-java11-linux-aarch64-${GRAALVM_VERSION}.tar.gz && \
    java --version

# Install Python 3.8.x
RUN apt-get install -y libncursesw5-dev \
    libssl-dev \
    libsqlite3-dev \
    tk-dev \
    libgdbm-dev \
    libc6-dev \
    libbz2-dev \
    libffi-dev \
    zlib1g-dev \
    liblzma-dev

RUN wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tar.xz -O /opt/Python-${PYTHON_VERSION}.tar.xz && \
    tar -xvf /opt/Python-${PYTHON_VERSION}.tar.xz -C /opt && \
    cd /opt/Python-${PYTHON_VERSION} && \
    ./configure --enable-optimizations && \
    make altinstall && \
    update-alternatives --install /usr/bin/python python /usr/local/bin/python3.8 1 && \
    update-alternatives --install /usr/bin/pip pip /usr/local/bin/pip3.8 1 && \
    rm /opt/Python-${PYTHON_VERSION}.tar.xz && \
    rm -r /opt/Python-${PYTHON_VERSION} && \
    cd / 

# Install Trino
RUN wget --quiet ${TRINO_URL} -O /opt/trino-server-${TRINO_VERSION}.tar.gz && \
    mkdir -p /opt/trino && \
    tar -xvzf /opt/trino-server-${TRINO_VERSION}.tar.gz \
        -C /opt/trino --strip-components 1 && \
    rm /opt/trino-server-${TRINO_VERSION}.tar.gz

# Copy configuration files on the host into the image
RUN ln -s /opt/trino/etc /etc/trino

# Specify the entrypoint to start
ENTRYPOINT launcher run