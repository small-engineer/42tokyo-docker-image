FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Etc/UTC

RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    tzdata && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3 python3-pip && \
    pip install pyyaml && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./install.yml /install.yml
COPY ./install_script.py /install_script.py

RUN chmod +x /install_script.py

# Define build argument (default: true)
ARG USE_YAML=true

RUN if [ "$USE_YAML" = "true" ]; then \
      python3 /install_script.py; \
    else \
      echo 'Skipping YAML installation'; \
    fi

# Set up C/C++ development tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    gcc-10 g++-10 \
    gcc-11 g++-11 \
    gcc-12 g++-12 \
    clang-12 clang-tidy-12 clang-tools-12 \
    libc6 libc6-dev libc6-dbg \
    libgcc-10-dev libgcc-11-dev libgcc-12-dev \
    python3.10 python3.10-venv python3.10-dev python3-pip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Configure GCC and Clang alternatives
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 10 \
    --slave /usr/bin/g++ g++ /usr/bin/g++-10 && \
    update-alternatives --install /usr/bin/clang clang /usr/bin/clang-12 10

RUN ln -sf /usr/bin/python3.10 /usr/bin/python

RUN gcc -v && g++ -v && clang -v && python --version

CMD ["/bin/bash"]
