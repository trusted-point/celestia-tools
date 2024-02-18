locals {
  dashboards = {
    "bridge_node_overview" = {
      enabled = var.bridge_node_overview_enabled
      dashboard = file("${path.module}/templates/bridge_node_overview.json")
    }
  }
}

# Resource: Datadog Dashboard for Celestia Bridge Node
# Description: This Terraform resource dynamically creates and manages a Datadog dashboard tailored for showcasing 
# various metrics associated with the Celestia Bridge Node. It leverages a dynamic approach using the `for_each` construct 
# to iterate over a predefined set of dashboard configurations. Each dashboard configuration is conditionally applied 
# based on its enabled status, allowing for flexible and scalable monitoring solutions.
resource "datadog_dashboard_json" "bridge_node_overview_dashboard" {
  for_each = {for key, dashboard in local.dashboards: key => dashboard if dashboard.enabled == "true"}

  dashboard = each.value.dashboard
}