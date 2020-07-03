From gis_base:latest

ENV HOME /home/arcgis

ADD start.sh ${HOME}
# Put your license file and a downloaded copy of the server software
# in the same folder as this Dockerfile
ADD --chown=arcgis:arcgis  *.prvc ${HOME}
ADD --chown=arcgis:arcgis ArcGIS_Server_Linux_108*.tar ${HOME}


# Start in the arcgis user's home directory.
WORKDIR ${HOME}
USER arcgis
# ESRI uses this in some scripts (including 'backup')
ENV LOGNAME arcgis

# Run the ESRI installer script as user 'arcgis' with these options:
#   -m silent         silent mode: don't pop up windows, we don't have a screen
#   -l yes            Agree to the License Agreement
RUN cd ArcGISServer && ./Setup -m silent --verbose -l yes -a ${HOME}/lic_server_108.prvc

RUN rm -rf ${HOME}/ArcGISServer

# Persist ArcGIS Server's data on the host's file system. Make sure these are writable by container.
VOLUME ["${HOME}/server/usr/config-store", \
        "${HOME}/server/usr/directories", \
        "${HOME}/server/usr/logs"]


EXPOSE 6080 6443

# Hmmm I wonder if I should check the HTTP or HTTPS service??
HEALTHCHECK --interval=30s --timeout=10s --retries=3 CMD curl -sS 127.0.0.1:6080 || exit 1

# Command that will be run by default when you do "docker run"
CMD ./start.sh && tail -f ./server/framework/etc/service_error.log