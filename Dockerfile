# Start by building the application.
FROM golang:1.21 as build

WORKDIR /app
COPY main.go .

# Initialize Go module and download dependencies
RUN go mod init cast.ai/vulnapp-lk && go mod tidy

# Build the Go server
RUN go build -o server .

# Use distroless as the base image to reduce attack surface
FROM gcr.io/distroless/static-debian12
COPY --from=build /app/server /server

# Expose port 3000
EXPOSE 3000

# Run the Go server
CMD ["/server"]
