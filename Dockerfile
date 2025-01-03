FROM ubuntu:20.04  

ENV DEBIAN_FRONTEND=noninteractive  

RUN apt-get update && apt-get install -y \
    ns2 \
    nam \
    tcl \
    tk \
    && rm -rf /var/lib/apt/lists/*  

WORKDIR /app  

COPY tcp-comparison.tcl /app/  

CMD ["ns", "tcp-comparison.tcl"] 