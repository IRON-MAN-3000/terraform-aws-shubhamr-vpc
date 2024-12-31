variable "region" {

    description = "About region"
    type = string
    default = "eu-north-1"
}



variable "subnet_config" {

  description = "Get the CIDR block for the subnet"
  type = map(object({
    cidr_block = string
    az    = string
    public = optional(bool, false) # we make this variable as an optional and false by default
  }))


    validation {  #here we have validatation on CIdr in subnet as subnet is a map so we need to use for loop and alltrue is a condintion whichj check all the subnet config give true as a value other wise got false
      condition     = alltrue([for config in var.subnet_config : can(cidrnetmask(config.cidr_block))])
      #condition = (alltrue[for config in var.subnet_config: can(cidrnetmask(config.cidr_block))])
      error_message = "Invalid CIDR format of subnet"
    }
  
}

variable "vpc_config" {
    description = "To get value of cidr block and name of the VPC"
    type = object({
      cidr_block = string
      name = string
    })

    validation {  #here we have validatation on CIdr
      
      condition = can(cidrnetmask(var.vpc_config.cidr_block))
      error_message = "Invalid CIDR please specify in correct format ${var.vpc_config.cidr_block}"
    }
    
  
}



