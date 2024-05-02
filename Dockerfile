# Use the official Golang base image to create a build artifact.
FROM golang:1.22 as builder

# Set the Current Working Directory inside the container.
WORKDIR /app

# Copy everything from the current directory to the Working Directory inside the container.
COPY . .

# Build the Go app.
RUN make build

# Use a lightweight Alpine image to run the application.
FROM alpine:latest

# Set the Current Working Directory inside the container.
WORKDIR /root/

# Copy the Pre-built binary file from the previous stage.
COPY --from=builder /app/bin/arbor-platform .

# Expose port 4444 to the outside world.
EXPOSE 4444

# Command to run the executable.
CMD ["./arbor-platform"]
