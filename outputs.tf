output "db_host" {
  value = module.rds.db_endpoint_address
}

output "db_port" {
  value = module.rds.db_endpoint_port
}

output "db_name" {
  value = module.rds.db_name
}
