FROM kasmweb/desktop:1.14.0-rolling
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########

# Generate a file with the current date in seconds and save it in the home directory
RUN date +%s > $HOME/date_in_seconds.txt


RUN  apt update &&  apt full-upgrade -y && apt install flatpak -y && flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo && flatpak install flathub nz.mega.MEGAsync


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
