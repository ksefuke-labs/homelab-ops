variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
  sensitive   = true
}

variable "n8n-psql-login" {
  description = "n8n pqsl login"
  type        = string
  sensitive   = true
}

variable "n8n-psql-password" {
  description = "n8n psql password"
  type        = string
  sensitive   = true
}