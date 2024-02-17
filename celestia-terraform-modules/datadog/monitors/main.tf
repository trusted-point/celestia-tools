locals {
  filter_tags = "{service:${var.service}"
  monitors = {
    "bridge_runtime_counter_is_stuck" = {
      enabled            = var.runtime_counter_is_stuck_enabled
      name               = "Bridge Runtime Counter Stuck"
      type               = "query alert"
      message            = var.runtime_counter_is_stuck_message
      escalation_message = var.runtime_counter_is_stuck_escalation_message
      priority           = 1
      query              = "${var.runtime_counter_is_stuck_aggregator}(${var.runtime_counter_is_stuck_timeframe}):sum:node_runtime_counter_in_seconds${local.filter_tags}.as_rate() > ${var.runtime_counter_is_stuck_threshold_critical}"
      thresholds         = {
        critical = var.runtime_counter_is_stuck_threshold_critical
        critical_recovery = var.runtime_counter_is_stuck_threshold_critical_recovery
      }
      metric_unit        = "count"
    },
    "bridge_low_header_sync_rate" = {
      enabled            = var.low_header_sync_rate_enabled
      name               = "Low Header Synchronization Rate"
      type               = "query alert"
      message            = var.low_header_sync_rate_message
      escalation_message = var.low_header_sync_rate_escalation_message
      priority           = 1
      query              = "pct_change(${var.low_header_sync_rate_aggregator}(${var.low_header_sync_rate_timeframe}),${var.low_header_sync_rate_shift_timeframe}):avg:total_synced_headers${local.filter_tags} <= ${var.low_header_sync_rate_threshold_critical}"
      thresholds         = {
        critical = var.low_header_sync_rate_threshold_critical
        critical_recovery = var.low_header_sync_rate_threshold_critical_recovery
      }
      metric_unit        = "headers/${var.low_header_sync_rate_timeframe}"
    },
  }
  shared_tags = ["service:${var.service}", "env:${var.environment}"]
}

# Resource: Datadog Monitor for Celestia Bridge Node
# Description: This Terraform resource dynamically creates and manages Datadog monitors tailored for monitoring 
# various metrics associated with the Celestia Bridge Node. It leverages a dynamic approach using the `for_each` construct 
# to iterate over a predefined set of monitor configurations. Each monitor configuration is conditionally applied 
# based on its enabled status, allowing for flexible and scalable monitoring solutions.
resource "datadog_monitor" "bridge_node_monitor" {
  for_each = {for key, monitor in local.monitors: key => monitor if monitor.enabled == "true"}

  name    = "[${var.environment}] [${var.service}] [${var.name}] ${each.value.name} {{#is_alert}}{{{comparator}}} {{threshold}}% ({{value}}%){{/is_alert}}{{#is_warning}}{{{comparator}}} {{warn_threshold}}% ({{value}}%){{/is_warning}}"
  type    = each.value.type
  priority = each.value.priority
  message = each.value.message != "" ? each.value.message : templatefile("${path.module}/templates/messages/bridge_node_monitor_message.tftpl", {
    critical_targets   = join(" ", distinct(lookup(var.notification_targets, "critical", [""])))
    environment        = var.environment
    service            = var.service
    name               = var.name
    metricType         = each.key
    metricUnit         = each.value.metric_unit
    threshold          = each.value.thresholds.critical
  })
  escalation_message = each.value.escalation_message != "" ? each.value.escalation_message : templatefile("${path.module}/templates/messages/bridge_node_monitor_escalation_message.tftpl", {
    critical_targets   = join(" ", distinct(lookup(var.notification_targets, "critical", [""])))
    environment        = var.environment
    service            = var.service
    name               = var.name
    metricType         = each.key
    metricUnit         = each.value.metric_unit
    threshold          = each.value.thresholds.critical
  })

  query = each.value.query

  monitor_thresholds {
    critical = each.value.thresholds.critical
    critical_recovery  = each.value.thresholds.critical_recovery
  }

  renotify_interval        = var.renotify_interval
  renotify_occurrences     = var.renotify_occurrences
  renotify_statuses        = var.renotify_statuses
  notify_no_data           = var.notify_no_data
  no_data_timeframe        = var.no_data_timeframe
  notification_preset_name = var.notification_preset_name
  include_tags             = true
  evaluation_delay         = var.evaluation_delay
  tags                     = concat(local.shared_tags, var.tags)
}