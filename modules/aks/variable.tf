variable "environment" {
  type = object({
    name = string
    type = string # non-prod, prod
    region = string
      
  })
}

variable "aks" {
  type = object({
    location      = string
    node_count =  number
    vm_size = string
    node_count_system = number
    vm_size_system = string

      })
}
# variable "location" {

# }

variable "tags" {
  type = map(string)
}

variable "region_name_mapper" {
  type = map(string)
}
