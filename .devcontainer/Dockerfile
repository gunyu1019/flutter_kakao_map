ARG VARIANT="ubuntu-22.04"
FROM mcr.microsoft.com/vscode/devcontainers/base-${VARIANT}

USER root

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends bundler

USER codespace

ARG COMMAND_LINE_TOOLS_VERSION="11076708"

# Install and Configuration Flutter
WORKDIR /home/codespace
RUN mkdir /home/codespace/opt && cd /home/codespace/opt
RUN git clone https://github.com/flutter/flutter.git -b stable

ENV FLUTTER_SDK /home/codespace/opt/flutter
ENV PATH $PATH:$FLUTTER_SDK/bin

# Install and Configuration Android-SDK
RUN wget https://dl.google.com/android/repository/commandlinetools-linux-${COMMAND_LINE_TOOLS_VERSION}_latest.zip
RUN unzip commandlinetools-linux-${COMMAND_LINE_TOOLS_VERSION}_latest.zip
RUN mkdir android-sdk
RUN mkdir android-sdk/platform-tools android-sdk/cmdline-tools
RUN mv cmdline-tools android-sdk/cmdline-tools/latest
RUN rm commandlinetools-linux-${COMMAND_LINE_TOOLS_VERSION}_latest.zip

ENV ANDROID_SDK_ROOT /home/codespace/opt/android-sdk
ENV PATH $PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin
ENV PATH $PATH:$ANDROID_SDK_ROOT/platform-tools

# Install and Configuration Android/Kotlin
ARG ANDROID_PLATFORM_VERSION="35"
ARG ANDROID_BUILD_TOOLS_VERSION="35.0.2"
ARG WORKSPACE="/workspaces/flutter_kakao_map"

RUN sdkmanager --sdk_root=${ANDROID_SDK_ROOT} "platform-tools" "platforms;${ANDROID_PLATFORM_VERSION}" "build-tools;${ANDROID_BUILD_TOOLS_VERSION}"
RUN flutter config --android-sdk ${ANDROID_SDK_ROOT}
RUN flutter precache 

WORKDIR ${WORKSPACE}/android
RUN cp $FLUTTER_SDK/bin/cache/artifacts/engine/android-x64/flutter.jar ${WORKSPACE}/android/libs/
RUN sed -i "s/\/\/ implementation files('libs\/flutter.jar')/implementation files('libs\/flutter.jar')/g" build.gradle
RUN gradle wrapper
RUN gradlew syncRelease