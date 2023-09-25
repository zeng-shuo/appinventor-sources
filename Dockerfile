FROM ubuntu


RUN apt-get update && \
    apt-get install -y openjdk-8-jdk git ant 
RUN echo $PWD
RUN git submodule update --init 
RUN apt-get install -y apt-transport-https ca-certificates gnupg curl 
RUN echo "deb https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list 
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - 
RUN apt-get update && apt-get install -y google-cloud-cli 
RUN curl https://sdk.cloud.google.com | bash 
RUN bash buildtools doctor 
RUN cd appinventor && ant MakeAuthKey && ant && \
    cd buildserver && ant RunLocalBuildServer 

CMD ["java_dev_appserver.sh","--port=8888","--address=0.0.0.0","appengine/build/war/"]
