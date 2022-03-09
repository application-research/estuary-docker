FROM golang:1.16.11-stretch
RUN apt-get update && \
    apt-get install -y wget jq hwloc ocl-icd-opencl-dev git libhwloc-dev pkg-config make  && \
    apt-get install -y cargo
WORKDIR /usr/src/estuary
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN cargo --help
RUN git clone https://github.com/application-research/estuary . && \
    RUSTFLAGS="-C target-cpu=native -g" FFI_BUILD_FROM_SOURCE=1 make all

COPY start.sh /usr/src/estuary/start.sh
RUN chmod +x /usr/src/estuary/start.sh
CMD /usr/src/estuary/start.sh
