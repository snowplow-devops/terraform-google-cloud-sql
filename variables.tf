variable "name" {
  description = "A name which will be pre-pended to the resources created"
  type        = string
}

variable "region" {
  description = "The name of the region to deploy within"
  type        = string
}

variable "database_version" {
  description = "The database version to use (https://cloud.google.com/sql/docs/db-versions)"
  type        = string
  default     = "POSTGRES_9_6"
}

variable "deletion_protection" {
  description = "Whether to protect the instance from accidental termination"
  type        = bool
  default     = false
}

variable "tier" {
  description = "The tier of database to deploy"
  type        = string
  default     = "db-f1-micro"
}

variable "authorized_networks" {
  description = "The list of CIDR ranges to allow access to the instance over"
  default     = []
  type = list(object({
    name  = string
    value = string
  }))
}

variable "db_name" {
  description = "The name of the database to create"
  type        = string
}

variable "db_username" {
  description = "The name of the administration user to create"
  type        = string
}

variable "db_password" {
  description = "The password of the administration user to create"
  type        = string
  sensitive   = true
}

variable "labels" {
  description = "The labels to append to this resource"
  default     = {}
  type        = map(string)
}

variable "ssl_mode" {
  description = "Specify how SSL connection should be enforced in DB connections"
  default     = "ALLOW_UNENCRYPTED_AND_ENCRYPTED"
  type        = string
}
