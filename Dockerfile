ARG ml_version=2010
ARG ml_arch=x86_64
FROM quay.io/pypa/manylinux${ml_version}_${ml_arch}
LABEL maintainer="Diamond Light Source Ltd"

ARG ml_version=2010
COPY build_${ml_version}.sh build_manylinux.sh
ARG ml_arch=x86_64
RUN bash build_manylinux.sh ${ml_arch} && rm build_manylinux.sh

CMD ["/bin/bash"]

