# output "compute_engine_public_ip" {
#   value = module.computer_engine.public_ip
# }

# output "lamp_server_public_ip" {
#   value = module.lamp_server.public_ip
# }

# output "kubernetes_cluster_name" {
#   value = module.k8_server.kubernetes_cluster_name
# }

output "zone" {
  value = data.google_client_config.defaults.zone
}

output "project" {
  value = data.google_client_config.defaults.project
}