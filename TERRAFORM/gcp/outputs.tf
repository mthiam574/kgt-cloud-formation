output "service_url" {
  description = "URL du service Cloud Run"
  value       = google_cloud_run_v2_service.kgt_app.uri
}

output "service_name" {
  description = "Nom du service Cloud Run"
  value       = google_cloud_run_v2_service.kgt_app.name
}
