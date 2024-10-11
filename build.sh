CR_PAT=GItHub 토큰

echo $CR_PAT | docker login ghcr.io -u Lseoksee --password-stdin
docker buildx build --push -t ghcr.io/fit-pin/fitpin-ar-backend ./AR-BackEnd/