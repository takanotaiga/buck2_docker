FROM ubuntu:jammy

SHELL ["/bin/bash", "-c"]
ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NOWARNINGS=yes
ENV PATH="/root/.cargo/bin:${PATH}"

RUN apt update && apt install -y curl build-essential git clang lld

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
    rustup uninstall stable && \
    rustup install nightly-2025-02-16 && \
    rustup default nightly-2025-02-16 && \
    cargo install --git https://github.com/facebook/buck2.git buck2 && \
    rustup uninstall nightly-2025-02-16 && \
    rm -rf ~/.cargo/git ~/.cargo/registry
