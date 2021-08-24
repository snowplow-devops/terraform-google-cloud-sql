output "self_link" {
  description = "The URI of the instance"
  value       = google_sql_database_instance.instance.self_link
}

output "connection_name" {
  description = "The connection name to be used when using things like Cloud SQL Proxy"
  value       = google_sql_database_instance.instance.connection_name
}

output "service_account_email_address" {
  description = "The SA email address assigned to the instance"
  value       = google_sql_database_instance.instance.service_account_email_address
}

output "first_ip_address" {
  description = "The first IP Address attached to the instance"
  value       = google_sql_database_instance.instance.first_ip_address
}

output "port" {
  description = "The port that the instance is available over"
  value       = 5432
}
