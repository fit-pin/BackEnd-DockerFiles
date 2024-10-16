# BackEnd-DockerFiles
AR, 웹 백엔드 Docker 컨테이너 통합 관리를 위한 리포지토리

## Docker-Compose 실행

```bash
DB_SSH_PRIVATE="$(cat <DB SSH키 파일>)" docker compose up
```

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
