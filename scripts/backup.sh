mkdir -p backup
tar -czf "backup/$(date +%Y-%m-%d_%H-%M-%S)_server.tar.gz" --exclude='server.jar' server
