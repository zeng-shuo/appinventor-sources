FROM ubuntu

ADD . /APP

WORKDIR /APP

RUN apt-get update && apt-get install -y openjdk-8-jdk git ant apt-transport-https ca-certificates gnupg curl && \
    echo "deb https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update && apt-get install -y google-cloud-cli && \
    curl https://sdk.cloud.google.com > install.sh && bash install.sh --disable-prompts --install-dir=/home && \
    echo y | /home/google-cloud-sdk/bin/java_dev_appserver.sh --port=8888 && \ 
    bash buildtools doctor 

WORKDIR /APP/appinventor

EXPOSE 8888

CMD ["bash -c","cd buildserver && nohup ant RunLocalBuildServer > build.log 2>&1 &","&& /home/google-cloud-sdk/b/java_dev_appserver.sh --port=8888 --address=0.0.0.0 appengine/build/war/"]
