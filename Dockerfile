# Start from the official OSRM image
FROM osrm/osrm-backend:latest

# Install tools needed to download and extract our data
# apt-get is for Debian-based images like this one
RUN apt-get update && apt-get install -y curl tar

# Set the working directory inside the container
WORKDIR /data

# Copy our startup script into the container
COPY start.sh .
RUN chmod +x ./start.sh

# Expose the port OSRM listens on
EXPOSE 5000

# The command that will run when the container starts
CMD ["./start.sh"]