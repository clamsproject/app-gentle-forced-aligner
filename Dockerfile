FROM ubuntu:19.10

RUN apt-get update && \
    apt-get install -y git python3 python3-pip python3-setuptools

RUN apt-get install -y ffmpeg
RUN apt-get install -y gfortran libblas-dev liblapack-dev python2.7
RUN git clone https://github.com/lowerquality/gentle.git /opt/gentle
WORKDIR /opt/gentle
RUN git checkout 1aa3f58ad01b728eed3ec21ffce4946bd39b1f3a
RUN sed -i.bak 's/wget/wget --no-check-certificate/g' install_models.sh
RUN bash ./install.sh

COPY ./ ./app
WORKDIR ./app
RUN pip3 install -r requirements.txt


ENTRYPOINT ["python3"]
CMD ["app.py"]
