FROM node:16

# Support for .docx to .pdf conversions
RUN \
  apt-get update && \
  apt-get install --yes libreoffice cabextract fontconfig xfonts-utils && \
  wget http://ftp.de.debian.org/debian/pool/contrib/m/msttcorefonts/ttf-mscorefonts-installer_3.6_all.deb && \
  dpkg -i ttf-mscorefonts-installer_3.6_all.deb && \
  # Google fonts
  wget https://github.com/google/fonts/archive/main.tar.gz -O gf.tar.gz && \
  tar -xf gf.tar.gz && \
  mkdir -p /usr/share/fonts/truetype/google-fonts && \
  find $PWD/fonts-main/ -name "*.ttf" -exec install -m644 {} /usr/share/fonts/truetype/google-fonts/ \; || return 1 && \
  rm -f gf.tar.gz && \
  # Remove the extracted fonts directory
  rm -rf $PWD/fonts-main && \
  # Remove the following line if you're installing more applications after this RUN command and you have errors while installing them
  rm -rf /var/cache/* && \
  fc-cache -f

LABEL maintainer="https://github.com/tbay06"
LABEL org.opencontainers.image.source=https://github.com/tbay06/docker-node16-libreoffice
