[<img src='assets/validator-guide.png' alt='banner' width= '99.9%'>]()
## Hardware requirements
```py
- Memory: 8 GB RAM
- CPU: Quad-Core
- Disk: 250 GB SSD Storage
- Bandwidth: 1 Gbps for Download/1 Gbps for Upload
- Ubuntu Linux 20.04 (LTS)
```

### 1. Create a `celestia-validator` user
```bash
sudo useradd celestia-validator -m -s /bin/bash -p ""
sudo usermod -aG sudo celestia-validator
sudo su - celestia-validator
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
### 4. Clone `celestia-app` repository
```bash
cd $HOME
git clone https://github.com/celestiaorg/celestia-app.git
cd celestia-app
git checkout tags/v1.6.0 -b v1.6.0
```
### 5. Build and install the `celestia-app`  binary
```bash
make install
```
### 6. Setup variables
```bash
# Modify if you need
# general
MONIKER="node"
CHAIN_ID="mocha-4"
EXTERNAL_IP=$(wget -qO- eth0.me)
# config.toml (default ports)
PROXY_APP_PORT=26658
RPC_PORT=26657
P2P_PORT=26656
PPROF_PORT=6060
PROMETHEUS_PORT=26660
# app.toml (default ports)
API_PORT=1317
GRPC_PORT=9090
GRPC_WEB_PORT=9091
```
### 7. Initialize the node
```bash
celestia-appd init $MONIKER --chain-id $CHAIN_ID && \
celestia-appd config chain-id $CHAIN_ID && \
celestia-appd config keyring-backend test
```
### 8. Set peers and seeds
```bash
SEEDS=$(curl -sL https://raw.githubusercontent.com/celestiaorg/networks/master/celestia/seeds.txt | head -c -1 | tr '\n' ',')
PEERS=$(curl -sL https://raw.githubusercontent.com/celestiaorg/networks/master/celestia/peers.txt | head -c -1 | tr '\n' ',')
sed -i.bak -e "s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/; s/^seeds *=.*/seeds = \"$SEEDS\"/" $HOME/.celestia-app/config/config.toml
```
### 8. Set ports
```bash
sed -i.bak \
    -e "s/\(proxy_app = \"tcp:\/\/\)\([^:]*\):\([0-9]*\).*/\1\2:$PROXY_APP_PORT\"/" \
    -e "s/\(laddr = \"tcp:\/\/\)\([^:]*\):\([0-9]*\).*/\1\2:$RPC_PORT\"/" \
    -e "s/\(pprof_laddr = \"\)\([^:]*\):\([0-9]*\).*/\1localhost:$PPROF_PORT\"/" \
    -e "/\[p2p\]/,/^\[/{s/\(laddr = \"tcp:\/\/\)\([^:]*\):\([0-9]*\).*/\1\2:$P2P_PORT\"/}" \
    -e "/\[p2p\]/,/^\[/{s/\(external_address = \"\)\([^:]*\):\([0-9]*\).*/\1${EXTERNAL_IP}:$P2P_PORT\"/; t; s/\(external_address = \"\).*/\1${EXTERNAL_IP}:$P2P_PORT\"/}" \
    -e "s/\(prometheus_listen_addr = \":\)\([0-9]*\).*/\1$PROMETHEUS_PORT\"/" $HOME/.celestia-app/config/config.toml
```
```bash
sed -i.bak \
    -e "/\[api\]/,/^\[/{s/\(address = \"tcp:\/\/\)\([^:]*\):\([0-9]*\)\(\".*\)/\1\2:$API_PORT\4/}" \
    -e "/\[grpc\]/,/^\[/{s/\(address = \"\)\([^:]*\):\([0-9]*\)\(\".*\)/\1\2:$GRPC_PORT\4/}" \
    -e "/\[grpc-web\]/,/^\[/{s/\(address = \"\)\([^:]*\):\([0-9]*\)\(\".*\)/\1\2:$GRPC_WEB_PORT\4/}" $HOME/.celestia-app/config/config.toml
```
### 9. Set min gas price 
```bash
sed -i.bak -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.002utia\"/" $HOME/.celestia-app/config/app.toml
```
### 10. Enable indexer if needed
```bash
sed -i.bak -e "s/^indexer *=.*/indexer = \"kv\"/" $HOME/.celestia-app/config/config.toml
```
### 11. Configure prunning to save storage 
```bash
sed -i.bak -e "s/^pruning *=.*/pruning = \"custom\"/" $HOME/.side/config/app.toml
sed -i.bak -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"1000\"/" $HOME/.side/config/app.toml
sed -i.bak -e "s/^pruning-interval *=.*/pruning-interval = \"10\"/" $HOME/.side/config/app.toml
```
### 12. Download genesis.json
```bash
wget -O $HOME/.celestia-app/config/genesis.toml https://raw.githubusercontent.com/celestiaorg/networks/master/mocha-4/genesis.json
```
### 13. Download addrbook.json
```bash
wget -O $HOME/.celestia-app/config/addrbook.json https://rpc-celestia-mocha.trusted-point.com/addrbook.json
```
### 14. Enable state sync (Or restore from [snapshot](https://docs.celestia.org/nodes/consensus-node#quick-sync))
```bash
SNAP_RPC="https://rpc-celestia-mocha.trusted-point.com"; \
LATEST_HEIGHT=$(curl -s $SNAP_RPC/block | jq -r .result.block.header.height); \
BLOCK_HEIGHT=$((LATEST_HEIGHT - 1500)); \
TRUST_HASH=$(curl -s "$SNAP_RPC/block?height=$BLOCK_HEIGHT" | jq -r .result.block_id.hash); \
echo "LATEST_HEIGHT: $LATEST_HEIGHT"
echo "TRUST_HEIGHT: $BLOCK_HEIGHT"
echo "TRUST_HASH: $TRUST_HASH"
```
```bash
sed -i.bak \
    -e "/\[statesync\]/, /^enable =/ s/=.*/= true/;" \
    -e "/^rpc_servers =/ s|=.*|= \"$SNAP_RPC,$SNAP_RPC\"|;" \
    -e "/^trust_height =/ s/=.*/= $BLOCK_HEIGHT/;" \
    -e "/^trust_hash =/ s/=.*/= \"$TRUST_HASH\"/" \
    $HOME/.side/config/app.toml
```
### 15. Create a systemd service file
```bash
sudo tee <<EOF >/dev/null /etc/systemd/system/celestia-appd.service
[Unit]
Description=Celestia Consensus Node
After=network-online.target

[Service]
User=$USER
ExecStart=$(which celestia-appd) start
Restart=on-failure
RestartSec=3
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF
```
### 16. Start the node
```bash
sudo systemctl enable celestia-appd
sudo systemctl restart celestia-appd
sudo journalctl -u celestia-appd -f -o cat
```
### 17. Logs
```bash
# State sync may take up to 10 minutes. Make sure "Discovering snapshot appears in the logs once the node is started"
```
### 18. Monitor sync status
```bash
curl -s localhost:$RPC_PORT/status | jq .result.sync_info
```
## Useful commands
### Restart
```bash
sudo systemctl restart celestia-appd
```
### Stop
```bash
sudo systemctl stop celestia-appd
```
### Check logs
```bash
sudo journalctl -u celestia-appd.service -f -o cat
```
### Upgrade celstia-appd
```bash
cd celestia-app
git fetch
git checkout tags/<version>

make install
# Check th version
celestia-appd --version
# Restrt the node
sudo systemctl restart celestia-appd && sudo journalctl -u celestia-appd -f -o cat
```
### Check sync status
```bash
curl -s localhost:$RPC_PORT/status | jq .result.sync_info
```
### Interacting with gRPC
```bash
wget https://github.com/fullstorydev/grpcurl/releases/download/v1.7.0/grpcurl_1.7.0_linux_x86_64.tar.gz
tar -xvf grpcurl_1.7.0_linux_x86_64.tar.gz
chmod +x grpcurl
./grpcurl  -plaintext  localhost:$GRPC_PORT list
```
### Interacting with REST API
```bash
curl localhost:$API_PORT/cosmos/staking/v1beta1/validators
```
### Delete the node
```bash
sudo su - celestia-validator

sudo systemctl stop celestia-appd && \
sudo systemctl disable celestia-appd && \
sudo rm /etc/systemd/system/celestia-appd.service && \
sudo rm -rf celestia-app .celestia-app
```
