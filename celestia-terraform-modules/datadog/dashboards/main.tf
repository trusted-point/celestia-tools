# Resource: Datadog Dashboard for Celestia Bridge Node
# Description: This Terraform resource is designed to dynamically create and manage a Datadog dashboard dedicated to showcasing the performance metrics of the Celestia Bridge Node. 
# It facilitates a comprehensive view into the operational aspects of the bridge node, enabling users to monitor key performance indicators (KPIs) and metrics essential for maintaining its health and efficiency. 
# The dashboard configuration is structured to provide a holistic overview, incorporating various widgets and visualizations that reflect real-time data and trends. 
# This resource empowers administrators and network operators with actionable insights, ensuring the Celestia Bridge Node operates at its optimal performance level.
resource "datadog_dashboard_json" "bridge_node_overview_dashboard" {
  dashboard = file("${path.module}/templates/bridge_node_overview.json")
}