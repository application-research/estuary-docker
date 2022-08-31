FROM golang:1.16.11-stretch as builder
# note (al): Should we update this to a newer version ^^ ?

RUN apt update && \
    apt install -y wget jq hwloc ocl-icd-opencl-dev git libhwloc-dev pkg-config make  && \
    apt install -y cargo
WORKDIR /usr/src/filecoin/lotus
#EXPOSE 3004

# steps derived from https://lotus.filecoin.io/developers/local-network/
ENV LOTUS_PATH=~/.lotus-local-net
ENV LOTUS_MINER_PATH=~/.lotus-miner-local-net
ENV LOTUS_SKIP_GENESIS_CHECK=_yes_
ENV CGO_CFLAGS_ALLOW="-D__BLST_PORTABLE__"
ENV CGO_CFLAGS="-D__BLST_PORTABLE__"

RUN git clone https://github.com/filecoin-project/lotus . \ 
        && git checkout v1.15.1 \ 
        && make 2k

FROM golang:1.16.11-stretch

ENV LOTUS_PATH=~/.lotus-local-net
ENV LOTUS_MINER_PATH=~/.lotus-miner-local-net
ENV LOTUS_SKIP_GENESIS_CHECK=_yes_
ENV CGO_CFLAGS_ALLOW="-D__BLST_PORTABLE__"
ENV CGO_CFLAGS="-D__BLST_PORTABLE__"

RUN apt-get update && apt-get install -y wget jq hwloc ocl-icd-opencl-dev git libhwloc-dev pkg-config make  && \
    apt-get install -y cargo

WORKDIR /usr/filecoin/lotus
COPY --from=builder /usr/src/filecoin/lotus/lotus .
COPY --from=builder /usr/src/filecoin/lotus/lotus-miner .
COPY --from=builder /usr/src/filecoin/lotus/lotus-seed .

RUN ./lotus fetch-params 2048
RUN ./lotus-seed pre-seal --sector-size 2KiB --num-sectors 2
RUN ./lotus-seed genesis new localnet.json
RUN ./lotus-seed genesis add-miner localnet.json ~/.genesis-sectors/pre-seal-t01000.json
CMD ./lotus daemon --lotus-make-genesis=devgen.car --genesis-template=localnet.json --bootstrap=false

# RUN ./lotus wallet import --as-default ~/.genesis-sectors/pre-seal-t01000.key
# RUN ./lotus-miner init --genesis-miner --actor=t01000 --sector-size=2KiB --pre-sealed-sectors=~/.genesis-sectors --pre-sealed-metadata=~/.genesis-sectors/pre-seal-t01000.json --nosync
# RUN ./lotus-miner run --nosync
