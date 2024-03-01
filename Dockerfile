FROM kasmweb/ubuntu-jammy-dind:1.15.0-rolling
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########


RUN  wget -O megasync_amd64.deb https://mega.nz/linux/repo/xUbuntu_22.04/amd64/megasync-xUbuntu_22.04_amd64.deb \
    && apt-get update \
    # && DEBIAN_FRONTEND=noninteractive apt-get -y upgrade \ 
    && apt-get install -y ./megasync_amd64.deb \
    && rm -f ./megasync_amd64.deb

######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME/Desktop 
RUN cp /usr/share/applications/megasync.desktop /home/kasm-user/Desktop \
    && chmod a+x /home/kasm-user/Desktop/megasync.desktop \
    && mkdir /home/kasm-user/MEGA \
    && ln -s /home/kasm-user/MEGA /home/kasm-user/Desktop \
    && chown -R 1000:0 $HOME


USER 1000
