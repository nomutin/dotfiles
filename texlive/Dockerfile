#bulid:  docker build -t texlive .
FROM alpine:3.9.4

WORKDIR /root/work

RUN apk update
RUN apk add perl wget fontconfig-dev  
RUN apk add xz tar  

ADD http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz /tmp/install-tl-unx.tar.gz  
RUN mkdir /tmp/install-tl-unx　
RUN tar -xvf /tmp/install-tl-unx.tar.gz -C /tmp/install-tl-unx --strip-components=1　
RUN echo "selected_scheme scheme-basic" >> /tmp/install-tl-unx/texlive.profile  
RUN /tmp/install-tl-unx/install-tl -profile /tmp/install-tl-unx/texlive.profile  

RUN TEX_LIVE_VERSION=$(/tmp/install-tl-unx/install-tl --version | tail -n +2 | awk '{print $5}'); \
    ln -s "/usr/local/texlive/${TEX_LIVE_VERSION}" /usr/local/texlive/latest
ENV PATH="/usr/local/texlive/latest/bin/x86_64-linuxmusl:${PATH}" 

RUN tlmgr install latexmk 
RUN touch /root/.latexmkrc
COPY ./app/config/.latexmkrc /root/.latexmkrc

RUN tlmgr install listings
RUN tlmgr install multirow
RUN tlmgr install collection-langjapanese
RUN tlmgr install collection-fontsrecommended
RUN tlmgr install collection-fontutils
RUN tlmgr install mhchem
RUN tlmgr install siunitx

RUN apk del xz tar
RUN rm -rf /var/cache/apk/*
RUN rm -rf /tmp/*

# References
# - https://github.com/blang/latex-docker
# - https://github.com/Paperist/docker-alpine-texlive-ja/blob/master/Dockerfile
