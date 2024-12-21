ARG VARIANT="ubuntu-22.04"
FROM mcr.microsoft.com/vscode/devcontainers/base:${VARIANT}

USER root

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends bundler

USER vscode

# Install and Configuration Flutter
WORKDIR /home/vscode
RUN git clone https://github.com/flutter/flutter.git -b stable

ENV FLUTTER_SDK="/home/vscode/flutter"
ENV PATH="$PATH:$FLUTTER_SDK/bin"

# Install Java
RUN wget https://download.java.net/java/GA/jdk18.0.2/f6ad4b4450fd4d298113270ec84f30ee/9/GPL/openjdk-18.0.2_linux-x64_bin.tar.gz
RUN tar zxvf openjdk-18.0.2_linux-x64_bin.tar.gz
ENV JAVA_HOME="/home/vscode/jdk-18.0.2"
ENV PATH="$PATH:$JAVA_HOME/bin"

# Install Gradle
RUN wget https://github.com/gradle/gradle-distributions/releases/download/v8.10.2/gradle-8.10.2-bin.zip
RUN unzip gradle-8.10.2-bin.zip
RUN mv gradle-8.10.2 gradle
ENV PATH="$PATH:/home/vscode/gradle/bin"

# Install and Configuration Android (SDK-manager)
ARG COMMAND_LINE_TOOLS_VERSION="11076708"

RUN wget https://dl.google.com/android/repository/commandlinetools-linux-${COMMAND_LINE_TOOLS_VERSION}_latest.zip
RUN unzip commandlinetools-linux-${COMMAND_LINE_TOOLS_VERSION}_latest.zip
RUN mkdir android-sdk
RUN mkdir android-sdk/platform-tools android-sdk/cmdline-tools
RUN mv cmdline-tools android-sdk/cmdline-tools/latest
RUN rm commandlinetools-linux-${COMMAND_LINE_TOOLS_VERSION}_latest.zip

ENV ANDROID_SDK_ROOT="/home/vscode/android-sdk"
ENV PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
ENV PATH="$PATH:$ANDROID_SDK_ROOT/platform-tools"

# Install and Configuration Android/Kotlin
ARG ANDROID_PLATFORM_VERSION="android-34"
ARG ANDROID_BUILD_TOOLS_VERSION="34.0.0"
ARG WORKSPACE="/workspaces/flutter_kakao_map"

RUN sdkmanager --sdk_root=${ANDROID_SDK_ROOT} "platform-tools" "platforms;${ANDROID_PLATFORM_VERSION}" "build-tools;${ANDROID_BUILD_TOOLS_VERSION}"
RUN flutter config --android-sdk ${ANDROID_SDK_ROOT}
RUN flutter precache 

# Configuration Kotlin
WORKDIR ${WORKSPACE}/android
RUN mkdir ${WORKSPACE}/android/libs/
RUN cp $FLUTTER_SDK/bin/cache/artifacts/engine/android-x64/flutter.jar ${WORKSPACE}/android/libs/
# RUN sed -i "s/\/\/ implementation files('libs\/flutter.jar')/implementation files('libs\/flutter.jar')/g" build.gradle
# RUN gradle wrapper
# RUN gradlew syncRelease
