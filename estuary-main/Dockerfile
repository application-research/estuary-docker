# syntax=docker/dockerfile:1

# ## Build
FROM golang:1.18-bullseye

# Default Arguments for the Build
ARG arg_estuary_main_hostname=http://localhost:3004
ARG arg_estuary_www_hostname=http://localhost:4443
ARG arg_fullnode_api=ws://api.chain.love
ARG arg_workdir=/app

# Env Variables for the Builds

# Let the container know where its working directory is.
ENV WORKDIR=$arg_workdir
# Estuary Hostname
ENV ESTUARY_MAIN_HOSTNAME=$arg_estuary_main_hostname
# Estuary WWW Hostname
ENV ESTUARY_WWW_HOSTNAME=$arg_estuary_www_hostname
# Full Filecoin Node API
ENV FULLNODE_API=$arg_fullnode_api

# Create build directory
WORKDIR /app

# Install and Configure External Dependencies
RUN apt-get update && \
    apt-get install -y wget jq hwloc ocl-icd-opencl-dev git libhwloc-dev pkg-config make  && \
    apt-get install -y cargo
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN cargo --help

# Copy our Source Code from the Git Repository, Download Dependencies, and Compile
RUN git clone https://github.com/banyancomputer/estuary . && \
    RUSTFLAGS="-C target-cpu=native -g" FFI_BUILD_FROM_SOURCE=1 make all

# Initialize our Statup Script
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Expose the Container on port 3004
EXPOSE 3004

CMD /app/start.sh