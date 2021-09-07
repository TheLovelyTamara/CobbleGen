FROM ubuntu:xenial

#essential programs
run apt update && apt install -y wget postgresql-client build-essential g++ libpq5 libpq-dev unzip git

#Get Cobol installed
RUN wget https://cobolworx.com/pages/downloads/gnucobol_3.1.2-1_amd64.deb 
RUN wget https://cobolworx.com/pages/downloads/cblgdb_4.27.1-1_amd64.deb
RUN apt install -y ./gnucobol_3.1.2-1_amd64.deb ./cblgdb_4.27.1-1_amd64.deb

#get esql
RUN wget https://github.com/opensourcecobol/Open-COBOL-ESQL/archive/refs/tags/v1.2.zip
RUN unzip ./v1.2.zip &&\
        cd /Open-COBOL-ESQL-1.2 &&\
        export CPATH=/usr/include/postgresql/ &&\
        ./configure &&\
        make &&\
        cd ./ocesql &&\
        ls -la &&\
        make install

# bugfix
RUN echo "+ %{!shared:%{!r:%{!fPIE:%{!pie:-fno-PIE -no-pie}}}}" > /usr/share/dpkg/no-pie-link.specs

# cleanup
RUN rm -f /gnucobol_3.1.2-1_amd64.deb /cblgdb_4.27.1-1_amd64.deb /v1.2.zip
WORKDIR /src
