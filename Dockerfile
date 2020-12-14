ARG ml_version=2010
FROM quay.io/pypa/manylinux${ml_version}_x86_64
LABEL maintainer="Diamond Light Source Ltd"

COPY build_${ml_version}.sh build_manylinux.sh
RUN bash build_manylinux.sh && rm build_manylinux.sh

CMD ["/bin/bash"]

