# Base image used for this image
FROM alpine:latest

# Starting working as root in its home folder
WORKDIR /root

# Downloading the necessary Alpine packages
RUN apk add --update nodejs curl npm

# Fetching the Elm binary directly from the sources
RUN curl -L -o elm.gz https://github.com/elm/compiler/releases/download/0.19.1/binary-for-linux-64-bit.gz

# Unzipping the binary archive
RUN gunzip elm.gz

# Allowing the binary to be run as an executable
RUN chmod +x elm

# Copying the binary to the global binaries' folder
RUN cp /root/elm /usr/local/bin/elm

# Creating a group for the unpriviledged user
RUN addgroup -g 1000 -S elm

# Creating the unpriviledged user
RUN adduser -h /home/elm -g "" -s /bin/sh -G elm -S -D -u 1000 elm

# Issuing the next command as the unpriviledged user
USER elm

# Creating the final working folder
RUN mkdir /home/elm/app

# Issuing the next command in the final working folder
WORKDIR /home/elm/app

# Allowing to install global package inside the unpriviledged user's home folder
RUN npm config set prefix /home/elm/.local

# Globall installation of Elm Test
RUN npm install --global elm-test

# Prefixing all command run with this image by the Elm Test binary path
ENTRYPOINT [ "/home/elm/.local/bin/elm-test", "--compiler", "/usr/local/bin/elm" ]

# Default argument if none are provided when running this image
CMD [ "--version" ]
