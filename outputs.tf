output "networkfirewall_rule_groups_id" {
  description = "Map of id values across all networkfirewall_rule_groups, keyed the same as var.networkfirewall_rule_groups"
  value       = { for k, v in aws_networkfirewall_rule_group.networkfirewall_rule_groups : k => v.id if v.id != null && length(v.id) > 0 }
}
output "networkfirewall_rule_groups_arn" {
  description = "Map of arn values across all networkfirewall_rule_groups, keyed the same as var.networkfirewall_rule_groups"
  value       = { for k, v in aws_networkfirewall_rule_group.networkfirewall_rule_groups : k => v.arn if v.arn != null && length(v.arn) > 0 }
}
output "networkfirewall_rule_groups_capacity" {
  description = "Map of capacity values across all networkfirewall_rule_groups, keyed the same as var.networkfirewall_rule_groups"
  value       = { for k, v in aws_networkfirewall_rule_group.networkfirewall_rule_groups : k => v.capacity if v.capacity != null }
}
output "networkfirewall_rule_groups_description" {
  description = "Map of description values across all networkfirewall_rule_groups, keyed the same as var.networkfirewall_rule_groups"
  value       = { for k, v in aws_networkfirewall_rule_group.networkfirewall_rule_groups : k => v.description if v.description != null && length(v.description) > 0 }
}
output "networkfirewall_rule_groups_encryption_configuration" {
  description = "Map of encryption_configuration values across all networkfirewall_rule_groups, keyed the same as var.networkfirewall_rule_groups"
  value       = { for k, v in aws_networkfirewall_rule_group.networkfirewall_rule_groups : k => one(v.encryption_configuration) if v.encryption_configuration != null && length(v.encryption_configuration) > 0 }
}
output "networkfirewall_rule_groups_name" {
  description = "Map of name values across all networkfirewall_rule_groups, keyed the same as var.networkfirewall_rule_groups"
  value       = { for k, v in aws_networkfirewall_rule_group.networkfirewall_rule_groups : k => v.name if v.name != null && length(v.name) > 0 }
}
output "networkfirewall_rule_groups_region" {
  description = "Map of region values across all networkfirewall_rule_groups, keyed the same as var.networkfirewall_rule_groups"
  value       = { for k, v in aws_networkfirewall_rule_group.networkfirewall_rule_groups : k => v.region if v.region != null && length(v.region) > 0 }
}
output "networkfirewall_rule_groups_rule_group" {
  description = "Map of rule_group values across all networkfirewall_rule_groups, keyed the same as var.networkfirewall_rule_groups"
  value       = { for k, v in aws_networkfirewall_rule_group.networkfirewall_rule_groups : k => one(v.rule_group) if v.rule_group != null && length(v.rule_group) > 0 }
}
output "networkfirewall_rule_groups_rules" {
  description = "Map of rules values across all networkfirewall_rule_groups, keyed the same as var.networkfirewall_rule_groups"
  value       = { for k, v in aws_networkfirewall_rule_group.networkfirewall_rule_groups : k => v.rules if v.rules != null && length(v.rules) > 0 }
}
output "networkfirewall_rule_groups_tags" {
  description = "Map of tags values across all networkfirewall_rule_groups, keyed the same as var.networkfirewall_rule_groups"
  value       = { for k, v in aws_networkfirewall_rule_group.networkfirewall_rule_groups : k => v.tags if v.tags != null && length(v.tags) > 0 }
}
output "networkfirewall_rule_groups_tags_all" {
  description = "Map of tags_all values across all networkfirewall_rule_groups, keyed the same as var.networkfirewall_rule_groups"
  value       = { for k, v in aws_networkfirewall_rule_group.networkfirewall_rule_groups : k => v.tags_all if v.tags_all != null && length(v.tags_all) > 0 }
}
output "networkfirewall_rule_groups_type" {
  description = "Map of type values across all networkfirewall_rule_groups, keyed the same as var.networkfirewall_rule_groups"
  value       = { for k, v in aws_networkfirewall_rule_group.networkfirewall_rule_groups : k => v.type if v.type != null && length(v.type) > 0 }
}
output "networkfirewall_rule_groups_update_token" {
  description = "Map of update_token values across all networkfirewall_rule_groups, keyed the same as var.networkfirewall_rule_groups"
  value       = { for k, v in aws_networkfirewall_rule_group.networkfirewall_rule_groups : k => v.update_token if v.update_token != null && length(v.update_token) > 0 }
}

