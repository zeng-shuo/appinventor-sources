FROM ubuntu


RUN set -u && \
    apt-get update && \
    apt-get install openjdk-8-jdk git ant && \
    git submodule update --init && \
    apt-get install -y apt-transport-https ca-certificates gnupg curl && \
    echo "deb https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update && apt-get install -y google-cloud-cli && \
    curl https://sdk.cloud.google.com | bash && \
    bash buildtools doctor && \
    cd appinventor && ant MakeAuthKey && ant && \
    cd buildserver && ant RunLocalBuildServer && cd ../.. \

CMD ["java_dev_appserver.sh","--port=8888","--address=0.0.0.0","appengine/build/war/"]
