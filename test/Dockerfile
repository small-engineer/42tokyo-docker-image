FROM 42image:latest

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Etc/UTC

COPY ./tests /tests

WORKDIR /tests

RUN make --version && \
    cmake --version && \
    gdb --version && \
    valgrind --version

CMD ["make", "test"]

