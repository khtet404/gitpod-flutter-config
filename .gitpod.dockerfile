FROM gitpod/workspace-full:latest

ENV ANDROID_HOME=/home/gitpod/android-sdk \
    FLUTTER_HOME=/home/gitpod/flutter

USER root

RUN curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    curl https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list && \
    apt-get update && \
    apt-get -y install build-essential dart libkrb5-dev gcc make gradle android-tools-adb android-tools-fastboot openjdk-8-jdk && \
    apt-get clean && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/*;

USER gitpod

RUN cd /home/gitpod && \
    wget -qO flutter_sdk.tar.xz \
    https://mirror.nju.edu.cn/flutter/flutter_infra/releases/stable/linux/flutter_linux_3.7.12-stable.tar.xz &&\
    tar -xvf flutter_sdk.tar.xz && \
    rm -f flutter_sdk.tar.xz

RUN cd /home/gitpod && \
    wget -qO android_studio.tar.xz \
    https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2022.2.1.19/android-studio-2022.2.1.19-linux.tar.gz && \
    tar -xvf android_studio.tar.xz && \
    rm -f android_studio.tar.xz

# TODO(tianhaoz95): make the name of the SDK file into an environment variable to avoid maintainance issue
RUN mkdir -p /home/gitpod/android-sdk && \
    mkdir -p /home/gitpod/android-sdk/cmdline-tools && \
    cd /home/gitpod/android-sdk/cmdline-tools && \
    wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip && \
    unzip commandlinetools-linux-9477386_latest.zip && \
    rm -f commandlinetools-linux-9477386_latest.zip && \
    mv -R cmdline-tools latest
