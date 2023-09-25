FROM ubuntu

ADD . /APP

WORKDIR /APP

RUN apt-get update && apt-get install -y openjdk-8-jdk apt-transport-https ca-certificates gnupg curl && \
    echo "deb https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update && apt-get install -y google-cloud-cli && \ 
    apt-get install -y google-cloud-sdk-app-engine-java
    #curl https://sdk.cloud.google.com | bash 
RUN bash buildtools doctor 

CMD ["/root/google-cloud-sdk/bin/java_dev_appserver.sh","--port=8888","--address=0.0.0.0","appengine/build/war/"]
