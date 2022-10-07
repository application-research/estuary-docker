FROM golang:1.17
RUN apt-get update && \
    apt-get install -y wget jq hwloc ocl-icd-opencl-dev git libhwloc-dev pkg-config make  && \
    apt-get install -y cargo
WORKDIR /usr/src/estuary
EXPOSE 3004

RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN cargo --help
RUN git clone https://github.com/application-research/estuary . && \
    RUSTFLAGS="-C target-cpu=native -g" FFI_BUILD_FROM_SOURCE=1 make deps estuary

COPY start.sh /usr/src/estuary/start.sh
RUN chmod +x /usr/src/estuary/start.sh

#ENV ESTUARY_TOKEN=$(/usr/src/estuary/start.sh)
#RUN echo Estuary Token is ${ESTUARY_TOKEN}
CMD /usr/src/estuary/start.sh