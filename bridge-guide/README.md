[<img src='assets/bridge-node.png' alt='banner' width= '99.9%'>]()

- [Hardware requirements](#hardware-requirements)
  - [1. Create a `celestia-bridge` user](#1-create-a-celestia-bridge-user)
  - [2. Update and install packages](#2-update-and-install-packages)
  - [3. Install Go](#3-install-go)
  - [4. Clone `celestia-node` repository](#4-clone-celestia-node-repository)
  - [5. Build the `celestia`  binary](#5-build-the-celestia--binary)
  - [6. Install it](#6-install-it)
  - [7. Build `cel-key` binary for birdge's keys managment](#7-build-cel-key-binary-for-birdges-keys-managment)
  - [8. Initialize a bridge node](#8-initialize-a-bridge-node)
  - [9. Make sure to make a backup of the menomic](#9-make-sure-to-make-a-backup-of-the-menomic)
  - [10. Fund your wallet with a few TIA tokens HERE and check the balance](#10-fund-your-wallet-with-a-few-tia-tokens-here-and-check-the-balance)
  - [11. You can check your wallet address by running the following command](#11-you-can-check-your-wallet-address-by-running-the-following-command)
  - [12. Increase Buffer Sizes](#12-increase-buffer-sizes)
  - [13. Create a systemd service file](#13-create-a-systemd-service-file)
  - [14. Start the service](#14-start-the-service)
  - [15. You should see such logs](#15-you-should-see-such-logs)
  - [16. Get your auth token to make RPC requests](#16-get-your-auth-token-to-make-rpc-requests)
  - [17. Get your Node ID](#17-get-your-node-id)
  - [18. Setup a monitoring \& alerting  using our **solution** with Datadog dashboard](#18-setup-a-monitoring--alerting--using-our-solution-with-datadog-dashboard)
- [Useful commands](#useful-commands)
  - [Restart](#restart)
  - [Stop](#stop)
  - [Check logs](#check-logs)
  - [Upgrade celstia-node](#upgrade-celstia-node)
  - [Get your Node ID](#get-your-node-id)
  - [Get Bridge's local height](#get-bridges-local-height)
  - [Get Bridge's network height](#get-bridges-network-height)
  - [Check balance](#check-balance)
  - [Delete the node](#delete-the-node)
## Hardware requirements
```py
- Memory: 4 GB RAM (minimum)
- CPU: 6 cores
- Disk: 10 TB SSD Storage
- Bandwidth: 1 Gbps for Download/1 Gbps for Upload
- Ubuntu Linux 20.04 (LTS)
```
### 1. Create a `celestia-bridge` user
```bash
sudo useradd celestia-bridge -m -s /bin/bash -p ""
sudo usermod -aG sudo celestia-bridge
sudo su - celestia-bridge
```
### 2. Update and install packages
```bash
sudo apt update && sudo apt upgrade -y && \
sudo apt install curl tar wget clang pkg-config libssl-dev libleveldb-dev jq build-essential bsdmainutils git make ncdu htop unzip bc fail2ban htop -y
```
### 3. Install Go
```bash
cd $HOME && \
ver="1.21.1" && \
wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz" && \
sudo rm -rf /usr/local/go && \
sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz" && \
rm "go$ver.linux-amd64.tar.gz" && \
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bash_profile && \
source $HOME/.bash_profile && \
go version
```
### 4. Clone `celestia-node` repository
```bash
git clone https://github.com/celestiaorg/celestia-node.git
cd celestia-node
git checkout tags/v0.12.4
```
### 5. Build the `celestia`  binary
```bash
make build
```
### 6. Install it
```bash
# This will put celestia bin the /usr/local/bin/ dir
sudo make install
# Make sure it works 
celestia version
```
### 7. Build `cel-key` binary for birdge's keys managment
```bash
make cel-key
sudo mv ./cel-key /usr/local/bin/
# Make sure it works 
cel-key help
```
### 8. Initialize a bridge node
```bash
# It will generate a new wallet named my_celes_key
cd $HOME
celestia bridge init --core.ip rpc-celestia-mocha.trusted-point.com --p2p.network mocha
```
### 9. Make sure to make a backup of the menomic
```py
NAME: my_celes_key
ADDRESS: celestia1rhw4ddktqh83ryw1wq4cnl5jt6ln65n0wv3f432
MNEMONIC (save this somewhere safe!!!):
ritual gym delay inspire load ....
```
### 10. Fund your wallet with a few TIA tokens [HERE](https://discord.gg/celestiacommunity) and check the balance
```bash
celestia state balance --node.store /home/celestia-mocha-bridge/.celestia-bridge-mocha-4

Example output:
#{
#  "result": {
#    "denom": "utia",
#    "amount": "10000000"
#  }
#}

To make this call you need to make sure Gateway is enabled in /home/celestia-mocha-bridge/.celestia-bridge-mocha-4/config.toml
# [Gateway]
#   Address = "localhost"
#   Port = "26659"
#   Enabled = true
```
### 11. You can check your wallet address by running the following command
```bash
cel-key list --keyring-backend test --node.type bridge --keyring-dir $HOME/.celestia-bridge-mocha-4/keys
```
### 12. Increase Buffer Sizes
```bash
sudo sysctl -w net.core.rmem_max=2500000
sudo sysctl -w net.core.rmem_max=2500000
```
### 13. Create a systemd service file
```bash
sudo tee <<EOF >/dev/null /etc/systemd/system/celestia-bridge.service
[Unit]
Description=Celestia Bridge Node
After=network-online.target

[Service]
User=$USER
ExecStart=$(which celestia) bridge start --core.ip rpc-celestia-mocha.trusted-point.com --p2p.network mocha-4 --core.grpc.port 9099 --core.rpc.port 26698 --keyring.accname my_celes_key --node.store $HOME/.celestia-bridge-mocha-4
Restart=on-failure
RestartSec=3
LimitNOFILE=1400000

[Install]
WantedBy=multi-user.target
EOF
```
### 14. Start the service
```bash
sudo systemctl enable celestia-bridge && \
sudo systemctl start celestia-bridge && \
sudo journalctl -u celestia-bridge.service -f -o cat
```
### 15. You should see such logs
[<img src='assets/logs.png' alt='banner' width= '99.9%'>]()

### 16. Get your auth token to make RPC requests
```bash
TOKEN=$(celestia bridge auth admin --p2p.network mocha-4)
echo $TOKEN
```
### 17. Get your Node ID
```bash
curl -X POST \
     -s \
     -H "Authorization: Bearer $TOKEN" \
     -H 'Content-Type: application/json' \
     -d '{"jsonrpc":"2.0","id":0,"method":"p2p.Info","params":[]}' \
     http://localhost:26658 | jq .result.ID
```
### 18. Setup a monitoring & alerting  using our [**solution**](https://github.com/trusted-point/celestia-tools/tree/main/terraform-modules/datadog) with Datadog dashboard
## Useful commands

### Restart
```bash
sudo systemctl restart celestia-bridge
```
### Stop
```bash
sudo systemctl stop celestia-bridge
```
### Check logs
```bash
sudo journalctl -u celestia-bridge.service -f -o cat
```
### Upgrade celstia-node
```bash
cd celestia-node
git fetch
git checkout tags/<version>
make build
make install
# Check th version
celestia --version
# Restrt the node
sudo systemctl restart celestia-bridge && sudo journalctl -u celestia-bridge.service -f -o cat
```
### Get your Node ID
```bash
TOKEN=$(celestia bridge auth admin --p2p.network mocha-4)
echo $TOKEN
```
```bash
curl -X POST \
     -s \
     -H "Authorization: Bearer $TOKEN" \
     -H 'Content-Type: application/json' \
     -d '{"jsonrpc":"2.0","id":0,"method":"p2p.Info","params":[]}' \
     http://localhost:26658 | jq .result.ID
```
### Get Bridge's local height
```bash
curl -X POST \
     -s \
     -H "Authorization: Bearer $TOKEN" \
     -H 'Content-Type: application/json' \
     -d '{"jsonrpc":"2.0","id":0,"method":"header.LocalHead","params":[]}' \
     http://localhost:26658 | jq .result.header.height
```
### Get Bridge's network height
```bash
curl -X POST \
     -s \
     -H "Authorization: Bearer $TOKEN" \
     -H 'Content-Type: application/json' \
     -d '{"jsonrpc":"2.0","id":0,"method":"header.NetworkHead","params":[]}' \
     http://localhost:26658 | jq .result.header.height
```
### Check balance
```bash
celestia state balance --node.store /home/celestia-mocha-bridge/.celestia-bridge-mocha-4

Example output:
#{
#  "result": {
#    "denom": "utia",
#    "amount": "10000000"
#  }
#}

To make this call you need to make sure Gateway is enabled in /home/celestia-mocha-bridge/.celestia-bridge-mocha-4/config.toml
# [Gateway]
#   Address = "localhost"
#   Port = "26659"
#   Enabled = true
```
### Delete the node
```bash
# DO NOT FORGET TO BACKUP YOUR KEYS at /home/celestia-bridge/.celestia-bridge-mocha-4/keys/
sudo su - celestia-bridge

sudo systemctl stop celestia-bridge && \
sudo systemctl disable celestia-bridge && \
sudo rm /etc/systemd/system/celestia-bridge.service && \
sudo rm -rf celestia-node .celestia-bridge-mocha-4
```
