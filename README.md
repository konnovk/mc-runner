# mc-runner

Билдим runner:
``` bash
docker build --build-arg USER_ID=$(id -u) --build-arg GROUP_ID=$(id -g) --tag mc-runner:dev .
```

Билдим jrpc jrps:
```bash
git clone https://github.com/fatedier/frp.git

docker build --tag frpc:dev -f ./frp/dockerfiles/Dockerfile-for-frpc ./frp

docker build --tag frps:dev -f ./frp/dockerfiles/Dockerfile-for-frps ./frp
```

Запуск frps:
``` bash
docker run --name frps --network host --volume ./cfg:/opt/frp --restart always -d frps:dev -c /opt/frp/frps.ini
```

Бэкап:
```bash
mkdir -p backup
tar -czf "backup/$(date +%Y-%m-%d_%H-%M-%S)_servers.tar.gz" servers
```
