docker run -d -v ./server:/mc --stop-timeout 60 -p 25565:25565 -p 25575:25575 --restart always --name mc-runner -it mc-runner:dev
