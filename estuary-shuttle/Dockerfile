FROM golang:1.17
RUN apt-get update && \
    apt-get install -y wget jq hwloc ocl-icd-opencl-dev git libhwloc-dev pkg-config make  && \
    apt-get install -y cargo
WORKDIR /usr/estuary-bin
WORKDIR /usr/src/estuary-shuttle
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN cargo --help

COPY start.sh /usr/src/estuary-shuttle/start.sh
RUN chmod +x /usr/src/estuary-shuttle/start.sh
CMD /usr/src/estuary-shuttle/start.sh
