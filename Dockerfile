FROM ubuntu:22.04

WORKDIR /home/

ARG USER_ID
ARG GROUP_ID

ENV TERM xterm-256color
ENV TZ=America/Sao_Paulo
ENV DEBIAN_FRONTEND=noninteractive
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ >/etc/timezone

RUN apt-get -y update && \
    	apt-get -y upgrade && \
	apt-get -y install sudo git vim cmake ninja-build clang lld libomp-dev protobuf-compiler jq software-properties-common wget python3-dev python3-distutils libomp5

RUN update-alternatives --install /usr/bin/cc cc /usr/bin/clang 100 && \
	update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++ 100 && \
	update-alternatives --install /usr/bin/python python /usr/bin/python3 100

RUN wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py
RUN pip install tqdm onnx numpy pz

RUN if [ ${USER_ID:-0} -ne 0 ] && [ ${GROUP_ID:-0} -ne 0 ]; then \
	groupadd -g ${GROUP_ID} user && \
	useradd -l -u ${USER_ID} -g ${GROUP_ID} user \
;fi

RUN adduser user sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN mkdir /home/user && chown user /home/user  && cp /etc/skel/.bashrc /home/user/.bashrc

USER user
