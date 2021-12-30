echo "pull and run server"
# docker build -t smart-contact-api-server .
docker rm -f $(docker ps | grep trufflesuite | awk '{print $1}')

docker run -d \
        -it \
	    --name trufflesuite \
        --net="host" \
        --restart unless-stopped \
        trufflesuite/ganache-cli:latest
docker rm -f $(docker ps | grep smart-contact-api-server | awk '{print $1}')

docker run -d \
        -it \
	    --name smart-contact-api-server \
        --env-file .env \
        --net="host" \
        --restart unless-stopped \
        smart-contact-api-server:latest

