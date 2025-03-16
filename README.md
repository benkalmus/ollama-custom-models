# Running LLMs locally!

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

---

# Running Ollama from docker:

Install Nvidia container toolkit
[instructions](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html)

```sh
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit

# Configure NVIDIA Container Toolkit

sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker

# Test GPU integration

sudo docker run --rm --runtime=nvidia --gpus all ubuntu nvidia-smi
```

#### NOTE

Configure nvidia-container-runtime config:

```sh
sudo nvim /etc/nvidia-container-runtime/config.toml
# change this to false
no-cgroups = false
```

#### NOTE

On Linux, suspending the machine will cause Ollama to not recognize GPU. To fix this run:

```sh
sudo rmmod nvidia_uvm && sudo modprobe nvidia_uvm
docker compose restart
```

Or to automate this, place the `nvidia-suspend-fix.service` to `/etc/systemd/system`:

```sh
chmod +x nvidia-suspend-fix.sh
sudo cp nvidia-suspend-fix.service /etc/systemd/system/
sudo cp nvidia-suspend-fix.sh /usr/local/bin/
```

##### !**IMPORTANT**

Update location of this repository (docker compose file) in `nvidia-suspend-fix.sh`

#### > [!IMPORTANT] Docker NVidia Issue fix

Seems like a docker issue with Nvidia GPU:

> [git issue](https://github.com/ollama/ollama/issues/4604)

```sh
# add this to
nvim /etc/docker/daemon.json
{
"exec-opts": ["native.cgroupdriver=cgroupfs"]
}
```
