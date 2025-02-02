# Creating custom ollama models:

Build your models:

```sh
ollama create <modelname> -f ./<modelpath>
```

## Fixing ollama to bind 0.0.0.0

### Find service file:

```sh
sudo nvim /etc/systemd/system/ollama.service
```

### Add env

Environment="OLLAMA_HOST=0.0.0.0:8080"

```sh
[Unit]
Description=Ollama Service
After=network-online.target

[Service]
ExecStart=/usr/local/bin/ollama serve
User=ollama
Group=ollama
Restart=always
RestartSec=3
Environment="PATH=/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:/home/benkalmus/.nix-profile/bin:/home/benkalmus/.local/bin:/home/benkalmus/.npm-global/bin:/home/benkalmus/.local/bin:/home/benkalmus/.asdf/bin:/usr/local/cuda-12/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/benkalmus/.asdf/shims:/usr/local/cuda/bin:/usr/local/go/bin"
Environment="OLLAMA_HOST=0.0.0.0:11434"
[Install]
WantedBy=default.target
```

then

```sh
sudo systemctl daemon-reload
sudo systemctl restart ollama
```
