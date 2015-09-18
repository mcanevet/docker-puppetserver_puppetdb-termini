FROM mcanevet/puppetserver:2.1.1-1

MAINTAINER mickael.canevet@camptocamp.com

ENV PUPPETDB_VERSION 3.1.0-1puppetlabs1
ENV PATH /opt/puppetlabs/bin:$PATH

RUN apt-get update \
  && apt-get install -y puppetdb-termini=$PUPPETDB_VERSION \
  && apt-get clean

RUN puppet config set storeconfigs true --section master \
  && puppet config set storeconfigs_backend puppetdb --section master \
  && puppet config set reports store,puppetdb --section master

RUN echo "---\nmaster:\n  facts:\n    terminus: puppetdb\n    cache: yaml\n" > `puppet config print route_file`
