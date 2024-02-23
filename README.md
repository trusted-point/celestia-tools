# Celestia-Tools

Welcome to the Celestia Tools repository! This repository houses a collection of services and tools meticulously crafted for monitoring the Celestia network and its constituent entities.

### About **Celestia**

* **[Celestia](https://celestia.org/)** is a modular consensus and data network, built to enable anyone to easily deploy their own blockchain with minimal overhead.

* Celestia provides consensus and security on-demand, enabling anyone to deploy a blockchain without the overhead of bootstrapping a new consensus network.

* Blockchains built on top of Celestia do not rely on honest majority assumptions for state validity, meaning that they can interoperate with the highest security standards.

* Because Celestia does not validate transactions, its throughput is not bottlenecked by state execution like traditional blockchains. Thanks to a property of data availability sampling, Celestia’s throughput scales with the number of users. 

<font size = 4>**[Website](https://celestia.org/) | [GitHub](https://github.com/celestiaorg/docs) | [Twitter](https://twitter.com/CelestiaOrg) | [Discord](https://discord.gg/5FVvx3WGfa) | [Docs](https://docs.celestia.org/) | [Whitepaper](https://celestia.org/resources/#whitepapers) | [Blog](https://blog.celestia.org/) | [Careers](https://celestia.org/careers/)**</font>
### Available Tools

| Tool              | Description                                                                                                                                                           |
|-------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **[Monitoring Bot](./monitoring-bot)**    | 🤖 Serves as a vital tool for Celestia network participants, offering comprehensive insights into the network's dynamics, validators, governance proceedings, upcoming upgrades, emergency alerts for DA and validator nodes, and key metrics. |
| **[Terraform Modules](./terraform-modules)** | 🛠️ Celestia Network's Terraform Modules, your comprehensive solution for effortlessly deploying, monitoring, and managing Celestia infrastructure. |
| **[Services](./services)** | 🔐 Various endpoints including RPC, gRPC, API, gRPC-Web, Websocket, addrbook.json and on-chain Peers & Rpc scanners for both Mainnet & Testnet. (Archive nodes) |

## License

Copyright 2024 TrustedPoint

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
