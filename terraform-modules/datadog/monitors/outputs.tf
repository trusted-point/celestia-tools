output "validator_monitor_ids" {
  value = { for key, monitor in datadog_monitor.bridge_node_monitor : key => monitor.id }
  description = "A map of validator monitor names to their respective Datadog monitor IDs."
}