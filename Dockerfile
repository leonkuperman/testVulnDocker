# Start by building the application.
FROM golang:1.21.0 as build

WORKDIR /app
COPY main.go .

# Initialize Go module
RUN go mod init cast.ai/vulnapp-lk

# Build the Go server
RUN go build -o server .

# Now copy it into our base image.
FROM gcr.io/distroless/static-debian12
COPY --from=build /app/server /

# Expose port 3000
EXPOSE 3000

# Run the Go server
CMD ["/server"]
