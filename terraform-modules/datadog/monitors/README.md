# Celestia Datadog Monitors

## Purpose

This module is designed for the easy creation of Datadog Monitors to monitor and visualize the performance and statistics of Celestia DA Nodes. It is tailored to generate the following Datadog Monitors:

- Bridge Node Runtime Counter Stuck 
- Bridge Node Low Header Synchronization Rate 

## Usage example

```hcl
module "datadog-monitors-celestia-bridge" {
  source = "./celestia-services/terraform-modules/datadog/monitors"

  service = "bridge"
  environment = "mainnet"
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 0.12.31 |
| <a name="requirement_datadog"></a> [datadog](#requirement_datadog) | >= 3.1.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_datadog"></a> [datadog](#provider_datadog) | >= 3.1.2 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="variable_environment"></a> [environment](#variable_environment) | Deployment environment of the Celestia Network being monitored. Common values include 'mainnet', 'testnet', or custom environment names. Default is set to 'testnet'. | `string` | `"mainnet"` | no |
| <a name="variable_service"></a> [service](#variable_service) | Type of service within the Celestia Network that is being monitored. For instance, 'bridge' represents a node that connects the data availability layer and the consensus layer. | `string` | `"bridge"` | no |
| <a name="variable_evaluation_delay"></a> [evaluation_delay](#variable_evaluation_delay) | The delay, in seconds, before evaluating the metric to account for data ingestion latency. Helps ensure data completeness for accurate monitoring. | `number` | `300` | no |
| <a name="variable_notify_no_data"></a> [notify_no_data](#variable_notify_no_data) | Enables alerts for 'no data' events, indicating possible issues with data reporting or collection from the DA Node. | `bool` | `true` | no |
| <a name="variable_no_data_timeframe"></a> [no_data_timeframe](#variable_no_data_timeframe) | Duration, in minutes, to wait before alerting on a 'no data' condition, signaling potential interruptions in data flow or metric collection. | `number` | `15` | no |
| <a name="variable_notification_preset_name"></a> [notification_preset_name](#variable_notification_preset_name) | Configures the detail level in monitor notifications. Options: 'show_all', 'hide_query', 'hide_handles', 'hide_all'. Tailors notifications to include essential information. | `string` | `"hide_handles"` | no |
| <a name="variable_renotify_interval"></a> [renotify_interval](#variable_renotify_interval) | Interval, in minutes, between re-notifications for unresolved issues, ensuring timely follow-ups on critical DA Node performance metrics. | `number` | `30` | no |
| <a name="variable_renotify_occurrences"></a> [renotify_occurrences](#variable_renotify_occurrences) | Specifies the maximum number of re-notification messages for unresolved alerts, controlling alert frequency on ongoing issues. | `number` | `2` | no |
| <a name="variable_renotify_statuses"></a> [renotify_statuses](#variable_renotify_statuses) | Defines the alert statuses (e.g., 'alert', 'warn', 'no data') that trigger re-notifications, allowing for targeted follow-ups on specific conditions. | `list(string)` | `["alert", "warn", "no data"]` | no |
| <a name="variable_notification_targets"></a> [notification_targets](#variable_notification_targets) | A map specifying notification targets for different alert thresholds. It allows defining custom notification channels for 'critical' and 'warning' alerts, ensuring appropriate alert routing. Each channel should be specified with a unique identifier, prefixed with '@'. Format: {'critical': ['@channel1', '@user'], 'warning': ['@channel2']}. | `map(list(string))` | `{}` | no |
| <a name="variable_tags"></a> [tags](#variable_tags) | A list of tags to be associated with the Datadog monitors. Tags are key-value pairs that help in categorizing and filtering monitors across different environments, teams, or service types, enhancing manageability and visibility. | `list(string)` | `[]` | no |
| <a name="variable_runtime_counter_is_stuck_enabled"></a> [runtime_counter_is_stuck_enabled](#variable_runtime_counter_is_stuck_enabled) | Enables monitoring for the bridge node runtime counter, a critical metric for assessing network participation efficiency. | `string` | `"true"` | no |
| <a name="variable_runtime_counter_is_stuck_message"></a> [runtime_counter_is_stuck_message](#variable_runtime_counter_is_stuck_message) | Customizable notification message for the Runtime Counter Stuck monitor, allowing for tailored alerts specific to bridge node operations. | `string` | "" | no |
| <a name="variable_runtime_counter_is_stuck_escalation_message"></a> [runtime_counter_is_stuck_escalation_message](#variable_runtime_counter_is_stuck_escalation_message) | A message to include with a re-notification for the Runtime Counter Stuck monitor escalation. | `string` | "" | no |
| <a name="variable_runtime_counter_is_stuck_aggregator"></a> [runtime_counter_is_stuck_aggregator](#variable_runtime_counter_is_stuck_aggregator) | Aggregation method for evaluating runtime counter over the specified timeframe, crucial for identifying performance trends. Valid options are 'min', 'max', 'avg'. | `string` | `"avg"` | no |
| <a name="variable_runtime_counter_is_stuck_timeframe"></a> [runtime_counter_is_stuck_timeframe](#variable_runtime_counter_is_stuck_timeframe) | Time window for assessing runtime counter. Valid options are 'last_1m', 'last_5m', 'last_10m', 'last_15m', 'last_30m', 'last_1h', 'last_2h', 'last_4h', 'last_1d'. | `string` | `"last_5m"` | no |
| <a name="variable_runtime_counter_is_stuck_threshold_critical"></a> [runtime_counter_is_stuck_threshold_critical](#variable_runtime_counter_is_stuck_threshold_critical) | Critical alert threshold for runtime counter (in seconds), beyond which the bridge's performance is considered severely impacted. | `number` | `0` | no |
| <a name="variable_runtime_counter_is_stuck_threshold_critical_recovery"></a> [runtime_counter_is_stuck_threshold_critical_recovery](#variable_runtime_counter_is_stuck_threshold_critical_recovery) | Critical alert recovery threshold for the runtime counter, indicating bridge node returning to normal operations. | `number` | `1` | no |
| <a name="variable_low_header_sync_rate_enabled"></a> [low_header_sync_rate_enabled](#variable_low_header_sync_rate_enabled) | Activates the monitor for observing low header synchronization rate. | `string` | `"true"` | no |
| <a name="variable_low_header_sync_rate_message"></a> [low_header_sync_rate_message](#variable_low_header_sync_rate_message) | Allows for a tailored alert message regarding low  header synchronization rate. | `string` | "" | no |
| <a name="variable_low_header_sync_rate_escalation_message"></a> [low_header_sync_rate_escalation_message](#variable_low_header_sync_rate_escalation_message) | A custom message to include with a re-notification for the Low Header Synchronization Rate monitor escalation. | `string` | "" | no |
| <a name="variable_low_header_sync_rate_aggregator"></a> [low_header_sync_rate_aggregator](#variable_low_header_sync_rate_aggregator) | Specifies the aggregation method (e.g., 'avg') for evaluating header synchronization rate, critical for understanding participation effectiveness. | `string` | `"avg"` | no |
| <a name="variable_low_header_sync_rate_timeframe"></a> [low_header_sync_rate_timeframe](#variable_low_header_sync_rate_timeframe) | Sets the timeframe for monitoring header synchronization rate, crucial for timely detection of decreased network engagement. | `string` | `"last_5m"` | no |
| <a name="variable_low_header_sync_rate_threshold_critical"></a> [low_header_sync_rate_threshold_critical](#variable_low_consensus_proposal_rate_threshold_critical) | Critical alert threshold for header synchronization rate, below which indicates significant issues with bridge node health. | `number` | `0` | no |
| <a name="variable_low_header_sync_rate_threshold_critical_recovery"></a> [low_header_sync_rate_threshold_critical_recovery](#variable_low_consensus_proposal_rate_threshold_critical_recovery) | Critical alert recovery threshold for header synchronization rate, indicating bridge node returning to normal operations. | `number` | `0.1` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_monitor_ids"></a> [monitor_ids](#output_validator_monitor_ids) | A map of Bridge Node monitor names to their respective Datadog monitor IDs |
<!-- END_TF_DOCS -->

## Resource Documentation
* [Datadog Monitors Documentation](https://docs.datadoghq.com/monitors/)
