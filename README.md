# BackEnd-DockerFiles

앱, 웹, AR 백엔드의 Docker 컨테이너 통합 관리를 위한 리포지토리

## Docker-Compose 실행

```bash
DB_SSH_PRIVATE="$(cat <DB SSH키 파일>)" \
APP_APPLICATION_YML="$(cat <APP application.yml 파일>)" \
WEB_APPLICATION_YML="$(cat <WEB application.yml 파일>)" \
docker compose -p fitpin up -d
```

### [베포 파일 다운로드](https://trello.com/c/pEPtJpEg/99-db-%EC%A0%91%EC%86%8D-%EC%A3%BC%EC%86%8C)


## 배포 구조

-   각각의 서비스들을 `nginx` 리버스 프록시로 묶어서 하나의 서버에서 배포해서 사용

### 배포 주소

-   `fitpin-ar`: https://fitpin.kro.kr/ar-api
-   `fitpin-app`: https://fitpin.kro.kr/app-api
-   `fitpin-web`: https://fitpin.kro.kr/web-api

### 각 서비스 포트번호

-   `fitpin-ar`: 80
-   `fitpin-app`: 8080
-   `fitpin-web`: 8080

## VTON-BackEnd 배포

> Runner의 용량 문제로 따로 빌드하여 배포

1. **Dcoker에 ghcr.io 로그인 하기**

    ```bash
    echo <개인토큰> | docker login ghcr.io -u <유저이름> --password-stdin
    ```

2. **ghcr.io 에 배포 하기**

    ```bash
    docker buildx build --push -t ghcr.io/fit-pin/fitpin-vton-backend ./VTON-BackEnd/
    ```

3. **컨테이너 시작**

    ```bash
    docker run -it --name fitpin-idm -p 80:80 --gpus all ghcr.io/fit-pin/fitpin-vton-backend
    ```

### 배포 주소 & 포트

> 현재는 비용문제로 사용안함

-   `포트`: 80
-   `주소`: https://fitpin.kro.kr/ar-idm-api
