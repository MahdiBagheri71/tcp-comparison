FROM ubuntu:20.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    make \
    tcl8.6 \
    tcl8.6-dev \
    tk8.6 \
    tk8.6-dev \
    perl \
    xgraph \
    libxt-dev \
    libx11-dev \
    libxmu-dev \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Download and install NS2
WORKDIR /tmp
RUN wget https://sourceforge.net/projects/nsnam/files/ns-2/2.35/ns-allinone-2.35.tar.gz \
    && tar xzf ns-allinone-2.35.tar.gz \
    && cd ns-allinone-2.35 \
    && ./install

# Set environment variables
ENV PATH="/tmp/ns-allinone-2.35/bin:/tmp/ns-allinone-2.35/tcl8.5.10/unix:/tmp/ns-allinone-2.35/tk8.5.10/unix:${PATH}"
ENV LD_LIBRARY_PATH="/tmp/ns-allinone-2.35/lib:${LD_LIBRARY_PATH}"

# Create working directory
WORKDIR /ns2-project

# Copy simulation scripts
COPY tcp-comparison.tcl .

# Default command
CMD ["ns", "tcp-comparison.tcl"]