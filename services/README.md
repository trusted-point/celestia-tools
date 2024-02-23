# TrustedPoint Services on Celestia

* **[Celestia](https://celestia.org/)** is a modular consensus and data network, built to enable anyone to easily deploy their own blockchain with minimal overhead.

* Celestia provides consensus and security on-demand, enabling anyone to deploy a blockchain without the overhead of bootstrapping a new consensus network.

* Blockchains built on top of Celestia do not rely on honest majority assumptions for state validity, meaning that they can interoperate with the highest security standards.

* Because Celestia does not validate transactions, its throughput is not bottlenecked by state execution like traditional blockchains. Thanks to a property of data availability sampling, Celestia’s throughput scales with the number of users. 

<font size = 4>**[Website](https://celestia.org/) | [GitHub](https://github.com/celestiaorg/docs) | [Twitter](https://twitter.com/CelestiaOrg) | [Discord](https://discord.gg/5FVvx3WGfa) | [Docs](https://docs.celestia.org/) | [Whitepaper](https://celestia.org/resources/#whitepapers) | [Blog](https://blog.celestia.org/) | [Careers](https://celestia.org/careers/)**</font>

## Mainnet
> chain-id: **celestia**
#### Node settings:
| Parameter | Value |
|---------------------------|-------------------------------------|
| Indexing | kv |
| Pruning | nothing |
| Min-retain-blocks | 0 |
| snapshot-interval | 1500 |
| snapshot-keep-recent | 2 |
| minimum-gas-prices | 0.002utia |
- **RPC:** https://rpc-celestia-mainnet.trusted-point.com
- **gRPC**: http://grpc-celestia-mainnet.trusted-point.com:9095
- **API**: https://api-celestia-mainnet.trusted-point.com
- **gRPC Web**: http://grpc-celestia-mainnet.trusted-point.com:9101
- **Websocket**: ws://rpc-celestia-mainnet.trusted-point.com:26655/websocket
- **Peers scanner** (Updates every 5 minutes): https://rpc-celestia-mainnet.trusted-point.com/peers.txt
- **RPC Nodes on-chain scanner** (Updates every 5 minutes): https://rpc-celestia-mainnet.trusted-point.com/rpc_list.json
- **Addrbook** (Updates every 5 minutes): https://rpc-celestia-mainnet.trusted-point.com/addrbook.json

## Testnet
> chain-id: **mocha-4**
#### Node settings:
| Parameter | Value |
|---------------------------|-------------------------------------|
| Indexing | kv |
| Pruning | nothing |
| Min-retain-blocks | 0 |
| snapshot-interval | 1500 |
| snapshot-keep-recent | 2 |
| minimum-gas-prices | 0.002utia |

- **RPC:** https://rpc-celestia-mocha.trusted-point.com
- **gRPC**: http://grpc-celestia-mocha.trusted-point.com:9095
- **API**: https://api-celestia-mocha.trusted-point.com
- **gRPC Web**: http://grpc-celestia-mainnet.trusted-point.com:9098
- **Websocket**: ws://rpc-celestia-mainnet.trusted-point.com:26698/websocket
- **Peers scanner** (Updates every 5 minutes): https://rpc-celestia-mocha.trusted-point.com/peers.txt
- **RPC Nodes on-chain scanner** (Updates every 5 minutes): https://rpc-celestia-mocha.trusted-point.com/rpc_list.json
- **Addrbook** (Updates every 5 minutes): https://rpc-celestia-mocha.trusted-point.com/addrbook.json
