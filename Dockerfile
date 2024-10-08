FROM ubuntu:24.04 AS rocm

ARG ROCM_VERSION=6.2
ARG AMDGPU_VERSION=6.2

RUN apt update -qq && DEBIAN_FRONTEND=noninteractive apt install --no-install-recommends -qq -y \
    wget \
    gpg \
    build-essential \
    gnupg\
    ca-certificates && \
    wget https://repo.radeon.com/rocm/rocm.gpg.key -O - | gpg --dearmor | tee /etc/apt/keyrings/rocm.gpg > /dev/null && \
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/rocm.gpg] https://repo.radeon.com/amdgpu/$AMDGPU_VERSION/ubuntu noble main" | tee /etc/apt/sources.list.d/amdgpu.list && \
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/rocm.gpg] https://repo.radeon.com/rocm/apt/$ROCM_VERSION noble main" | tee --append /etc/apt/sources.list.d/rocm.list

COPY rocm-pin-600 /etc/apt/preferences.d/rocm-pin-600

RUN apt update -qq && DEBIAN_FRONTEND=noninteractive apt install --no-install-recommends -qq -y \
    rocm && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

CMD ["rocm-smi"]