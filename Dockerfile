# Set base image
FROM ubuntu:latest

# Update packages and install essential tools
RUN apt-get update -y \
    && apt-get install -y ca-certificates curl gnupg

# Set up Node.js repository
RUN mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_16.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list

# Install Node.js
RUN apt-get update -y \
    && apt-get install nodejs -y

# Create directory for the app and copy contents
RUN mkdir ./MyApp \
    && mkdir ./MyApp/subfolder \
    && touch ./MyApp/subfolder/example.txt \
    && echo "This is an example file." > ./MyApp/subfolder/example.txt

# Copy the Node.js application files into the container
COPY ./MyApp ./MyApp

# Set the working directory to the app directory
WORKDIR ./MyApp

# Install npm dependencies
RUN npm install

# Expose port 3000
EXPOSE 3000

# Set the default command to start the app
CMD ["node", "index.js"]


