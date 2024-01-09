FROM quay.io/prometheus/busybox:latest AS download

WORKDIR /

# Slicer-4.10.2-linux-amd64 revision
RUN wget -qO- https://slicer-packages.kitware.com/api/v1/item/60add733ae4540bf6a89c030/download | tar xvz

# UKFTracktography
# https://extensions.slicer.org/view/UKFTractography/28257/linux
RUN wget -qO- https://slicer-packages.kitware.com/api/v1/item/5f44a875e1d8c75dfc7055fb/download | tar xvz

FROM docker.io/library/python:2.7-buster

# install older version of whitematteranalysis which uses Python 2.7
RUN \
    --mount=type=cache,sharing=locked,target=/root/.cache/pip/wheels \
    pip install cython==0.22 \
    && pip install https://github.com/SlicerDMRI/whitematteranalysis/archive/9d24e5e832ceb02ef0fce47f1089774e8e47d407.tar.gz

# install system dependencies for Slicer
RUN \
    --mount=type=cache,sharing=locked,target=/var/cache/apt \
    apt-get update \
    && apt-get install -y libsm6 libxext6 libxt6 libglu1-mesa libxrender1 \
    libpulse-mainloop-glib0 libnss3 libxcomposite1 libxcursor1 libxrandr2 libasound2 libegl1

COPY --from=download /Slicer-4.10.2-linux-amd64 /opt/Slicer-4.10.2
COPY --from=download /28257-linux-amd64-UKFTractography-gitbb0b6f2-2020-07-28 /opt/28257-linux-amd64-UKFTractography-gitbb0b6f2-2020-07-28

ENV PATH=/opt/whitematteranalysis/bin:/opt/28257-linux-amd64-UKFTractography-gitbb0b6f2-2020-07-28/lib/Slicer-4.10/cli-modules:/opt/Slicer-4.10.2:/opt/Slicer-4.10.2/bin:$PATH \
    LD_LIBRARY_PATH=/opt/28257-linux-amd64-UKFTractography-gitbb0b6f2-2020-07-28/lib/Slicer-4.10/qt-loadable-modules:/opt/Slicer-4.10.2/lib:$LD_LIBRARY_PATH
