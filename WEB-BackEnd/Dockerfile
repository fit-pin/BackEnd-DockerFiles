# ubuntu 베이스 이미지 사용
FROM da864268/my-ubuntu

LABEL maintainer="da864268@naver.com"
LABEL description="fitpin"
LABEL org.opencontainers.image.source=https://github.com/fit-pin/fitpin_backend_web

# bash 로 변경
SHELL ["/bin/bash", "-c"]

# JDK-17 설치
RUN apt update && apt upgrade -y && apt install -y openjdk-17-jdk

# USER_NAME 변수 선언
ARG USER_NAME=fitpin

# fitpin 계정 생성
RUN userdel -rf ubuntu; \
adduser --disabled-password ${USER_NAME}

# fitpin 으로 전환
USER ${USER_NAME}
WORKDIR "/home/${USER_NAME}"

# JDK-17 환경변수 설정
RUN echo -e "\n\n" >> ~/.bashrc && \
echo -e "export JAVA_HOME=\"/usr/lib/jvm/$(ls /usr/lib/jvm | grep java-17-openjdk)\"" >>~/.bashrc && \
echo -e "PATH=$JAVA_HOME/bin:\$PATH" >>~/.bashrc

# fitpin_backend_web clone
RUN git clone https://github.com/fit-pin/fitpin_backend_web.git
WORKDIR "/home/${USER_NAME}/fitpin_backend_web"

#DB 터널링을 위한 SSH 키 생성
ARG DB_SSH_PRIVATE
RUN mkdir src/main/resources/dbssh && echo "$DB_SSH_PRIVATE" > src/main/resources/dbssh/AWSkey.ppk && \
chmod +x gradlew

CMD [ "/bin/bash", "-c",  "git pull && ./gradlew bootRun"]