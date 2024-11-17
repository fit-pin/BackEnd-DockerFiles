# ubuntu 베이스 이미지 사용
FROM da864268/my-ubuntu

LABEL maintainer="da864268@naver.com"
LABEL description="fitpin"
LABEL org.opencontainers.image.source=https://github.com/fit-pin/fitpin_backend_app

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

# fitpin_backend_app clone
RUN git clone https://github.com/fit-pin/fitpin_backend_app.git
WORKDIR "/home/${USER_NAME}/fitpin_backend_app"

# gradlew 실행권한 주기
RUN chmod +x gradlew

#실행 할때 처음 실행 여부 판단하여 DB_SSH_PRIVATE 환경변수로 AWSkey.ppk 생성
# APP_APPLICATION_YML 환경변수로 application.yml 생성
CMD git pull; \
if ! [ -f  ./.initfile ]; then \
    mkdir src/main/resources/dbssh; \
    echo "$DB_SSH_PRIVATE" > src/main/resources/dbssh/private.ppk; \
    echo "$APP_APPLICATION_YML" > src/main/resources/application.yml; \
    touch ./.initfile; \
fi; \
./gradlew bootRun
