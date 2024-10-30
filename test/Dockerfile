FROM 42image:latest

COPY ./src /src

WORKDIR /src

RUN make --version && \
    cmake --version && \
    gdb --version && \
    valgrind --version

CMD ["make", "test"]

