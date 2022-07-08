##### TAGS #####
variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  default     = ""
}

##### Network #####
variable "public_subnet_tags" {
  description = "Additional tags for the public subnets"
  default     = {}
}

variable "private_subnet_tags" {
  description = "Additional tags for the private subnets"
  default     = {}
}

##### VPC #####
variable "cidr" {
  description = "The CIDR block for the VPC"
  default     = "192.168.0.0/23"
  type        = string
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  default     = "default"
}

variable "enable_dns_hostnames" {
  description = "should be true if you want to use private DNS within the VPC"
  default     = true
}

variable "enable_dns_support" {
  description = "should be true if you want to use private DNS within the VPC"
  default     = true
}

variable "use_internal_dhcp" {
  description = "If set to true will use the dhcp set given by var.dhcp_set_id"
}

### dhcp_options ###
variable "dns_servers" {
  description = "List of DNS Servers"
  type        = list
  default     = ["AmazonProvidedDNS"]
}

variable "ntp_servers" {
  description = "List of NTP servers, default uses amazon time sync services"
  type        = list
  default     = ["169.254.169.123"]
}


##### Subnet #####
variable "public_subnets_cidr" {
  description = "CIDR for public subets"
  default     = []
}

variable "private_subnets_cidr" {
  description = "cidr for private subnets"
  default     = []
  type        = list
}

variable "map_public_ip_on_launch" {
  description = "should be false if you do not want to auto-assign public IP on launch"
  default     = true
}

