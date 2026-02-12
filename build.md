docker buildx build \  
 --platform linux/amd64,linux/arm64,linux/arm/v7 \
 -t kkmadhpuriya/rukovoditel:latest \
 -t kkmadhpuriya/rukovoditel:3.6.4 \
 --push \
 .
