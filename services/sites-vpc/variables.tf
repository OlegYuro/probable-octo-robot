#Main.tf
variable "aws_region" {
  description = "Region where infra will be built"
  type        = string
}

variable "aws_account_id" {
  description = "Account ID that infra will be built under"
  type        = string
}

variable "environment" {
  description = "Environment that service is being built in"
  type        = string
}

variable "owners" {
  description = "Owners of the service"
  type        = string
}

variable "role" {
  description = "The tag for role"
  type        = string
  default     = "oleg test"
}

variable "service" {
  description = "Service that is being built in"
  type        = string
}

variable "location" {
  description = "which cloud is the service being built"
  type        = string
  default     = "aws"
}


### vpc.tf ###
variable "cidr" {
  description = "The VPC Cidr"
}
variable "public_subnets_cidr" {
  description = "CIDR for public subets"

}
variable "private_subnets_cidr" {
  description = "cidr for private subnets"
}

variable "use_internal_dhcp" {
  description = "If true then vpc will use internal dns zone hosted in route53"
  default     = true
}

### cert.tf ###
variable "cert_domain" {
  description = "domain name"
}

### alb.tf ###
variable "idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle"
  type        = string
  default     = 300
}

variable "load_balancer_type" {
  description = "The type of load balancer to create. Possible values are application or network"
  type        = string
  default     = "application"
}

