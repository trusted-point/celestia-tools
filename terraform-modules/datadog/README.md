# Celestia Terraform Datadog Modules

Explore the Celestia Terraform Datadog Modules directory, dedicated to providing Terraform modules crafted to streamline the deployment of essential Datadog resources. These modules are meticulously designed to empower efficient monitoring and observability across Celestia network entities, enhancing your monitoring capabilities and ensuring a seamless experience in overseeing the Celestia network.

### Prerequisites

Before you begin using the Terraform modules in this directory to deploy Datadog resources for monitoring the Celestia network, ensure that you have the following prerequisites in place:

### DataDog Provider Configuration

You will need to configure the DataDog provider in your Terraform environment to establish a connection with your Datadog account. Below is an example of how to configure the provider in your Terraform configuration:

```hcl
provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}
```

Both **datadog_api_key** and **datadog_app_key** are unique to each Datadog account and are essential for authenticating your Terraform deployments with Datadog. To set these values, create a `terraform.tfvars` file in your working directory and define the keys as follows:

```hcl
datadog_api_key = "<your_datadog_api_key>"
datadog_app_key = "<your_datadog_app_key>"
```

Replace **your_datadog_api_key_here** and **your_datadog_app_key_here** with your actual Datadog API key and application key.

### Configuring Datadog Agent for Custom Metrics

To collect custom metrics from SUI Validator or Fullnode Prometheus endpoints, you need to configure the Datadog agent. Follow these steps:

#### Install Datadog Agent
1. Install the Datadog agent using the installation method appropriate for your platform. You can find installation instructions on the official Datadog website: [Datadog Agent Installation](https://docs.datadoghq.com/agent/?tab=Linux).

#### Enable Datadog Openmetrics Integration
2. Enable the Datadog Openmetrics integration through the Datadog UI on the Integrations page.

#### Configure Openmetrics Check
3. Create a configuration file named `conf.yaml` within the Datadog agent's configuration directory for the Openmetrics check. You can use the configuration file provided in this repository: `./datadog_conf/openmetrics.yaml`. This file is pre-configured to scrape SUI Validator metrics. Replace the placeholders marked in `<*>` brackets with your custom values.

#### Save the Configuration
4. Save the `conf.yaml` file and verify the Datadog agent's health checks to ensure that the configuration was saved correctly. Use the following command:

```shell
datadog-agent check openmetrics
```

#### Restart the Agent

Restart the Datadog agent to apply the new configuration. The agent will now scrape metrics from the SUI Validator Prometheus endpoint.

#### Monitor Custom Metrics

You can now explore custom metrics from the SUI Validator or Fullnode in the Datadog UI's metrics explorer. The same process can be repeated for Fullnode metrics. Additionally, you can add multiple targets to the Openmetrics configuration file to scrape metrics from multiple servers.

With the DataDog provider and Openmetrics check configured correctly, you'll be ready to use the Terraform modules to deploy and manage Datadog resources for monitoring the SUI network effectively.

### Modules

Explore the specialized modules available within this directory:

- [**dashboards**](./dashboards/): This subdirectory contains Terraform modules tailored for creating and managing Datadog dashboards specifically configured to visualize critical data and insights related to the SUI network and its components.

- [**monitors**](./monitors/): Inside this subdirectory, you'll discover Terraform modules designed to facilitate the setup and management of Datadog monitors. These monitors play a crucial role in proactively detecting and alerting on performance issues and anomalies within the SUI network.

- [**service_level_objectives**](./service_level_objectives/): The service level objectives (SLOs) are a fundamental aspect of any monitoring strategy. In this subdirectory, you'll find Terraform modules that simplify the creation and management of SLO resources within Datadog, allowing you to define and track the reliability of your SUI network services effectively.

Feel free to navigate to the subdirectory that aligns with your specific monitoring needs. Each subdirectory's README provides detailed information on how to use the corresponding Terraform modules, along with configuration options and best practices.

Choose the module that suits your requirements and leverage the power of Datadog for monitoring and ensuring the performance and reliability of the SUI network.

## Usage example

```hcl
module "datadog_sui_dashboards" {
  source = "./datadog/dashboards"
}

module "datadog_sui_monitors" {
  source = "./datadog/monitors"

  name = "my_validator"
  service = "validator"
  chain_id = "4c78adac"
  environment = "testnet"
}

module "datadog-sui-service_level_objectives" {
  source = "../datadog/service_level_objectives"

  name = "my_validator"
  service = "validator"
  chain_id = "4c78adac"
  environment = "testnet"

  consensus_latency_monitor_ids = [
    module.datadog_monitors.validator_monitor_ids["validator_high_consensus_latency"]
  ]

  owned_objects_certificates_execution_latency_monitor_ids = [
    module.datadog_monitors.validator_monitor_ids["validator_high_owned_objects_certificates_execution_latency"]
  ]

  shared_objects_certificates_execution_latency_monitor_ids = [
    module.datadog_monitors.validator_monitor_ids["validator_high_shared_objects_certificates_execution_latency"]
  ]

  certificate_creation_rate_monitor_ids = [
    module.datadog_monitors.validator_monitor_ids["validator_low_certificate_creation_rate"]
  ]

  consensus_reliability_monitor_ids = [
    module.datadog_monitors.validator_monitor_ids["validator_low_consensus_proposal_rate"]
  ]
}
```

This code snippet demonstrates how to use Terraform modules to deploy Datadog monitoring for the SUI Validator. It includes the following modules:

- `datadog_sui_dashboards`: Deploys Datadog dashboards.
- `datadog_sui_monitors`: Sets up Datadog monitors specific to the SUI Validator.
- `datadog-sui-service_level_objectives`: Configures Service Level Objectives (SLOs) for the SUI Validator based on various metrics.

The configuration includes specifying the name, service, chain ID, and environment for the SUI Validator, as well as associating monitors with specific metrics for monitoring and alerting. This example provides a comprehensive setup for monitoring SUI Validator performance.


git filter-branch --tree-filter 'rm -rf test/' --prune-empty HEAD