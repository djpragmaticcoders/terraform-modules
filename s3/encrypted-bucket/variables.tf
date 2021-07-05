variable "bucket" {}
variable "kms_key_id" {}
variable "versioning_enabled" { default = false }
variable "logging_target_bucket" { default = null }
variable "logging_target_prefix" { default = null }
variable "policy" { default = "" } # uses default policy specified in locals, if not provided here
variable "enable_transition" { default = false }
variable "days_to_transition" { default = 14 }
variable "transition_storage_class" { default = "GLACIER" }
variable "enable_expiration" { default = false }
variable "days_to_expiration" { default = 90 }
variable "sse_algorithm" { default = "aws:kms" }

variable "cors_enabled" { default = false }
variable "cors_allowed_headers" {
  type = list
  default = [
    "*",
  ]
}
variable "cors_allowed_methods" {
  type = list
  default = []
}
variable "cors_allowed_origins" {
  type = list
  default = []
}