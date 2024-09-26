# Use the official Golang image as the build stage
FROM golang:1.21 as build

# Create app directory
WORKDIR /app

# Copy the Go server code to the container
COPY main.go .

# Initialize Go module
RUN go mod init cast.ai/vulnapp-lk

# Build the Go server
RUN go build -o server .

# Use distroless as the base image for the final stage
FROM gcr.io/distroless/static-debian12

# Copy the built Go server from the build stage
COPY --from=build /app/server /server

# Expose port 3000
EXPOSE 3000

# Run the Go server
CMD ["/server"]
