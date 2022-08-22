FROM golang:1.17.9-buster as builder

RUN apt update && \
    apt install -y wget jq hwloc ocl-icd-opencl-dev git libhwloc-dev pkg-config make  && \
    apt install -y cargo
WORKDIR /usr/src/filecoin/lotus
#EXPOSE 3004

RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN cargo --help

# steps derived from https://lotus.filecoin.io/developers/local-network/
ENV LOTUS_PATH=~/.lotus-local-net
ENV LOTUS_MINER_PATH=~/.lotus-miner-local-net
ENV LOTUS_SKIP_GENESIS_CHECK=_yes_
ENV CGO_CFLAGS_ALLOW="-D__BLST_PORTABLE__"
ENV CGO_CFLAGS="-D__BLST_PORTABLE__"

RUN git clone https://github.com/filecoin-project/lotus . \ 
        && git checkout v1.17.0 \ 
        && RUSTFLAGS="-C target-cpu=native -g" FFI_BUILD_FROM_SOURCE=1 make clean 2k

#FROM golang:1.17.9-buster

#ENV LOTUS_PATH=~/.lotus-local-net
#ENV LOTUS_MINER_PATH=~/.lotus-miner-local-net
#ENV LOTUS_SKIP_GENESIS_CHECK=_yes_
#ENV CGO_CFLAGS_ALLOW="-D__BLST_PORTABLE__"
#ENV CGO_CFLAGS="-D__BLST_PORTABLE__"

#RUN apt-get update && apt-get install -y wget jq hwloc ocl-icd-opencl-dev git libhwloc-dev pkg-config make

#WORKDIR /usr/src/filecoin/lotus
#COPY --from=builder /usr/src/filecoin/lotus/lotus* .

# lotus daamon
RUN ./lotus fetch-params 2048
RUN ./lotus-seed pre-seal --sector-size 2KiB --num-sectors 2
RUN ./lotus-seed genesis new localnet.json
RUN ./lotus-seed genesis add-miner localnet.json ~/.genesis-sectors/pre-seal-t01000.json
# RUN ./lotus daemon --lotus-make-genesis=devgen.car --genesis-template=localnet.json --bootstrap=false &

RUN mkdir /root/.lotus-local-net
ADD ./config.toml /root/.lotus-local-net

# lotus miner
#RUN ./lotus wallet import --as-default ~/.genesis-sectors/pre-seal-t01000.key
#RUN ./lotus-miner init --genesis-miner --actor=t01000 --sector-size=2KiB --pre-sealed-sectors=~/.genesis-sectors --pre-sealed-metadata=~/.genesis-sectors/pre-seal-t01000.json --nosync
#CMD ./lotus-miner run --nosync

# CMD ["./lotus daemon --lotus-make-genesis=devgen.car --genesis-template=localnet.json --bootstrap=false", "tail -f /dev/null"]

# CMD ./lotus daemon --lotus-make-genesis=devgen.car --genesis-template=localnet.json --bootstrap=false && \
#    tail -f /dev/null

ADD ./entry.sh /root/entry.sh
RUN chmod +x /root/entry.sh
ENTRYPOINT ["/root/entry.sh"]

#CMD entry.sh