output "dashboard_urls" {
  value = { for key, dashboard in datadog_dashboard_json.celestia_dashboards : key => dashboard.url }
  description = "A map of Celestia dashboard names to their respective Datadog URLs."
}