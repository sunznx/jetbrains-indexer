FROM openjdk:22-slim

# Shared indexing works best
# when you use the IDE
# corresponding to the language
# your project is in
ARG IDE=ideaIU
ARG IDE_SHORT=idea
ARG IDE_CODE=idea
ARG IDE_VERSION=2023.2

# persist build args for runtime
# see https://www.saltycrane.com/blog/2021/04/buildtime-vs-runtime-environment-variables-nextjs-docker/#setting-dynamic-buildtime-environment-variables-that-are-available-at-runtime-also
ENV IDE=$IDE
ENV IDE_SHORT=$IDE_SHORT
ENV IDE_CODE=$IDE_CODE
ENV IDE_VERSION=$IDE_VERSION

ARG IDE_TAR=${IDE}-${IDE_VERSION}.tar.gz
ARG IJ_SHARED_INDEXES_TOOL_VERSION=0.9.8

# Runtime variables
ENV INDEXES_CDN_URL=http://localhost:25561/project
ENV PROJECT_DIR="/project"
ENV SHARED_INDEX_BASE="/shared-index"

## Install IDE
RUN wget -nv https://download-cf.jetbrains.com/${IDE_CODE}/${IDE_TAR} && \
    tar xzf ${IDE_TAR} && \
    tar tzf ${IDE_TAR} | head -1 | sed -e 's/\/.*//' | xargs -I{} ln -s {} ide && \
    rm ${IDE_TAR}

# Install ij-shared-indexes-tool-cli
RUN wget https://packages.jetbrains.team/maven/p/ij/intellij-shared-indexes/com/jetbrains/intellij/indexing/shared/ij-shared-indexes-tool-cli/${IJ_SHARED_INDEXES_TOOL_VERSION}/ij-shared-indexes-tool-cli-${IJ_SHARED_INDEXES_TOOL_VERSION}.zip -O ij-shared-indexes-tool-cli.zip && \
    unzip ij-shared-indexes-tool-cli.zip && \
    rm ij-shared-indexes-tool-cli.zip && \
    mv ij-shared-indexes-tool-cli-${IJ_SHARED_INDEXES_TOOL_VERSION} ij-shared-indexes-tool-cli


COPY entrypoint.sh entrypoint.sh
CMD ./entrypoint.sh
