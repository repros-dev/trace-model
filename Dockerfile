FROM cirss/repro-parent:latest

# copy exports into new Docker image
COPY exports /repro/exports

# copy the repro boot setup script from the distribution and run it
ADD ${REPRO_DIST}/boot-setup /repro/dist/
RUN bash /repro/dist/boot-setup

USER repro

# install required external repro modules
RUN repro.require blazegraph-service master ${CIRSS}
RUN repro.require blaze 0.2.7 ${CIRSS_RELEASE}
RUN repro.require geist 0.2.7 ${CIRSS_RELEASE}
RUN repro.require shell-notebook master ${REPROS_DEV}
RUN repro.require graphviz-runtime master ${REPROS_DEV} --util

# install contents of the exports directory as a repro module
RUN repro.require trace-model exports --demo

# use a local directory named tmp for each demo
RUN repro.env REPRO_DEMO_TMP_DIRNAME tmp

CMD  /bin/bash -il
