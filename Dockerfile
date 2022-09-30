FROM cirss/repro-parent:latest

# copy exports into new Docker image
COPY exports /repro/exports

# copy the repro boot setup script from the distribution and run it
ADD ${REPRO_DIST}/boot-setup /repro/dist/
RUN bash /repro/dist/boot-setup

USER repro

# install required repro modules
RUN repro.require geist 0.2.7 ${CIRSS_RELEASE}
RUN repro.require blazegraph-service master ${CIRSS}
RUN repro.require blaze 0.2.7 ${CIRSS_RELEASE}

CMD  /bin/bash -il
