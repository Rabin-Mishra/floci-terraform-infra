variable "db_identifier" {

}
variable "db_username" {

}
variable "db_password" {

}
variable "db_name" {

}
variable "allocated_storage" {

}
variable "instance_class" {

}
variable "engine" {

}


resource "aws_db_instance" "app_db" {
  identifier          = var.db_identifier
  username            = var.db_username
  password            = var.db_password
  db_name             = var.db_name
  allocated_storage   = var.allocated_storage
  instance_class      = var.instance_class
  engine              = var.engine
  engine_version      = "8.0"
  skip_final_snapshot = true
  publicly_accessible = false

  # Additional configuration options can be added here as needed

}

output "db_endpoint_address" {
  value = aws_db_instance.app_db.address

}

output "db_name" {
  value = aws_db_instance.app_db.db_name

}
output "db_endpoint_port" {
  value = aws_db_instance.app_db.port
}
