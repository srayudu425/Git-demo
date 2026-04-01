variable "sp_name" {
  description = "Service Principal name"
}

#for_each with list → same scope
#for_each with map → different scopes

variable "role_assignments" {
  type = map(object({
    role  = string
    scope = string
  }))
}