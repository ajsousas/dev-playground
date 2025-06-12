# Use a base image with Java and a suitable Linux distribution
FROM ubuntu:latest

# Update package lists and install necessary tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    openjdk-21-jdk \
    maven \
    git \
    curl \
    wget \
    unzip \
    sudo \
    xvfb \
    x11vnc \
    fluxbox \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install VS Code Server (code-server)
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Set up a user for development (important for security)
ARG DEV_USER=developer
ARG DEV_GROUP=developer

# Check if the group exists before creating it, using a more reliable method
RUN id -g $DEV_GROUP &>/dev/null || groupadd --gid 1002 $DEV_GROUP

# Create the user with a unique UID and add them to the group
RUN useradd --uid 1001 -m $DEV_USER

# Add the user to the specified group
RUN adduser $DEV_USER $DEV_GROUP

# Copy script (important for running VNC and code-server)
COPY docker-entrypoint.sh /usr/local/bin/

# Set execute permissions BEFORE switching to the developer user
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Create necessary vscode directory
RUN mkdir -p /home/$DEV_USER/.vscode-server

# Copy settings.json to configure VS Code
COPY settings.json /home/$DEV_USER/.vscode-server/Machine/settings.json
# Copy extensions.json to configure VS Code extensions
COPY extensions.json /home/$DEV_USER/.vscode-server/extensions/extensions.json

# Set ownership of the .vscode-server directory to the developer user
RUN chown -R $DEV_USER:$DEV_GROUP /home/$DEV_USER/.vscode-server

USER $DEV_USER
WORKDIR /home/$DEV_USER/app

# Install VS Code Java extension
RUN code-server \
  --install-extension vscjava.vscode-java-debug \
  --extensions-dir /home/$DEV_USER/.vscode-server/extensions

# Install Language Support for Java extension 
RUN code-server \
  --install-extension redhat.java \
  --extensions-dir /home/$DEV_USER/.vscode-server/extensions

# Expose ports
EXPOSE 8080
# For code-server (VS Code)
EXPOSE 5900
# For VNC

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]