FROM kasmweb/desktop:1.10.0-rolling
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########


RUN  wget -O megasync_amd64.deb https://mega.nz/linux/MEGAsync/xUbuntu_18.04/amd64/megasync_4.6.1-2.1_amd64.deb \
    && apt-get update \
    && apt-get install -y ./megasync_amd64.deb

######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000
