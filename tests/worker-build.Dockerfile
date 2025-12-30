FROM cgr.dev/chainguard/wolfi-base:latest

# Copy packages, index, and signing key
COPY repository/ /repository/

# Add the melange signing key
RUN cp /repository/melange.rsa.pub /etc/apk/keys/melange.rsa.pub

# Add local repository to APK
RUN mkdir -p /etc/apk/repositories.d && \
    echo "/repository" > /etc/apk/repositories.d/local.list

# Update package cache
RUN apk update

# Test: Install the package
RUN apk add --no-cache worker-build

# Verify installation
RUN which worker-build && worker-build --version
