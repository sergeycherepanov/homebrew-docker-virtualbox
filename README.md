# Homebrew Docker Virtualbox
This formulas resolves the Docker issue on AMD based MacOS (Ryzentosh). But can be used on any Mac.

## Installation

### Install the Virtualbox from the Oracle website or via the homebrew:
```bash
brew cask install virtualbox
```

### Install the docker-virtualbox via Homebrew

```bash
brew tap sergeycherepanov/docker-virtualbox
brew install docker-virtualbox
```

### Configure the docker-virtualbox requirements
> WARNING: Only this commands requires root permissions, all next should be run under your user

Ensure the NFS exports file exists
```bash
sudo touch /etc/exports
```

Allow the staff group to configure NFS shares and ip balancer without password prompt  
```bash
echo "%staff ALL=(ALL) NOPASSWD: /sbin/nfsd
%staff ALL=(ALL) NOPASSWD: /bin/cp /etc/nfs.conf /etc/nfs.conf.bak
%staff ALL=(ALL) NOPASSWD: /usr/bin/tee /etc/exports
%staff ALL=(ALL) NOPASSWD: /usr/bin/tee /etc/nfs.conf
%staff $(brew --prefix docker-virtualbox)/bin/gobetween
"| sudo tee /etc/sudoers.d/docker-machine-nfs
```

> Reboot your system to be sure that sudoers applied


### Configure the environment

If you didn't install Docker for Mac you can link binaries instead of PATH update
```
brew link --force --overwrite docker-virtualbox
```

Otherwise configure the PATH variable
```bash
# For the bash
echo "export PATH=\"$(brew --prefix docker-virtualbox)/bin:\$PATH\"" >> ~/.bashrc
# For the zsh
echo "export PATH=\"$(brew --prefix docker-virtualbox)/bin:\$PATH\"" >> ~/.zshrc
```

Reload the shell
```
exec $SHELL
```

### Start the docker-virtualbox service

> It should creates and configure the fm
> The live log will be available in `/tmp/docker-virtualbox.log`
```bash
brew services start docker-virtualbox 
```

### Verify installation

Test the Docker by running Nginx
```bash
docker run -d -p 8989:80 nginx
curl -v localhost:8989
```

## Additional information

SSH connection to the docker-machine
```bash
docker-machine ssh docker
```

To stop the service just run
```bash
brew services stop docker-virtualbox 
```

To setup environment for 3rd party tools (`ctop` as example)
```
source /tmp/docker-virtualbox.env
```

Manual port forwarding 
> In some cases the forwarding rule can be broken, and you need to configure it again manually
```bash
pf 8989 -e docker
```
## Know issues
* Cisco Anyconnect VPN brokes ip filter rules on the local interface. Need to replace the `pf` with some ip balancer (`traefik` as example).
