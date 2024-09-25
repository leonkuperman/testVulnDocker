# Use debian:10 as the base image
FROM debian:10

# Install necessary dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Set the Go version to install
ENV GO_VERSION 1.21.0

# Download and install Go
RUN wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz && \
    rm go${GO_VERSION}.linux-amd64.tar.gz

# Update PATH environment variable
ENV PATH $PATH:/usr/local/go/bin

# Verify the Go installation
RUN go version

# Create app directory
WORKDIR /app

# Copy the Go server code to the container
COPY main.go .

# Initialize Go module
RUN go mod init cast.ai/vulnapp-lk

# Build the Go server
RUN go build -o server .

# Expose port 3000
EXPOSE 3000

# Run the Go server
CMD ["./server"]