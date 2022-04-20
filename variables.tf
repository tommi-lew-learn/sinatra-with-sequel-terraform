variable "project_id" {
  description = "Google Cloud Platform Service Project ID"
  type        = string
  sensitive   = true
}

variable "google_key_file" {
  description = "Path to Google Cloud Platform Service Account JSON key file"
  type        = string
  sensitive   = true
}

# TODO: Re-evaluate if this is considered sensitive
variable "container_image" {
  description = "Container image to deploying into Cloud Run"
  type        = string
  sensitive   = true
}

variable "db_instance_name" {
  type    = string
  default = "cloudrun-sql"
}

variable "db_name" {
  description = "Database username"
  type        = string
  default     = "sinatra_to_sequel_database"
}

variable "db_username" {
  description = "Database username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}
