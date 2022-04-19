ARG ml_version=2010
ARG ml_arch=x86_64
FROM quay.io/pypa/manylinux${ml_version}_${ml_arch}
LABEL maintainer="Diamond Light Source Ltd"

COPY build_${ml_version}.sh build_manylinux.sh
COPY add_win32_cross_compile.sh add_win32_cross_compile.sh
RUN bash build_manylinux.sh ${ml_arch} && rm build_manylinux.sh && rm add_win32_cross_compile.sh

CMD ["/bin/bash"]

