variable "networkfirewall_rule_groups" {
  description = <<EOT
Map of networkfirewall_rule_groups, attributes below
Required:
    - capacity
    - name
    - type
Optional:
    - description
    - region
    - rules
    - tags
    - tags_all
    - encryption_configuration (block):
        - key_id (optional)
        - type (required)
    - rule_group (block):
        - reference_sets (optional, block):
            - ip_set_references (optional, block):
                - ip_set_reference (required, block):
                    - reference_arn (required)
                - key (required)
        - rule_variables (optional, block):
            - ip_sets (optional, block):
                - ip_set (required, block):
                    - definition (required)
                - key (required)
            - port_sets (optional, block):
                - key (required)
                - port_set (required, block):
                    - definition (required)
        - rules_source (required, block):
            - rules_source_list (optional, block):
                - generated_rules_type (required)
                - target_types (required)
                - targets (required)
            - rules_string (optional)
            - stateful_rule (optional, block):
                - action (required)
                - header (required, block):
                    - destination (required)
                    - destination_port (required)
                    - direction (required)
                    - protocol (required)
                    - source (required)
                    - source_port (required)
                - rule_option (required, block):
                    - keyword (required)
                    - settings (optional)
            - stateless_rules_and_custom_actions (optional, block):
                - custom_action (optional, block):
                    - action_definition (required, block):
                        - publish_metric_action (required, block):
                            - dimension (required, block):
                                - value (required)
                    - action_name (required)
                - stateless_rule (required, block):
                    - priority (required)
                    - rule_definition (required, block):
                        - actions (required)
                        - match_attributes (required, block):
                            - destination (optional, block):
                                - address_definition (required)
                            - destination_port (optional, block):
                                - from_port (required)
                                - to_port (optional)
                            - protocols (optional)
                            - source (optional, block):
                                - address_definition (required)
                            - source_port (optional, block):
                                - from_port (required)
                                - to_port (optional)
                            - tcp_flag (optional, block):
                                - flags (required)
                                - masks (optional)
        - stateful_rule_options (optional, block):
            - rule_order (required)
EOT

  type = map(object({
    capacity    = number
    name        = string
    type        = string
    description = optional(string)
    region      = optional(string)
    rules       = optional(string)
    tags        = optional(map(string))
    tags_all    = optional(map(string))
    encryption_configuration = optional(object({
      key_id = optional(string)
      type   = string
    }))
    rule_group = optional(object({
      reference_sets = optional(object({
        ip_set_references = optional(list(object({
          ip_set_reference = list(object({
            reference_arn = string
          }))
          key = string
        })))
      }))
      rule_variables = optional(object({
        ip_sets = optional(list(object({
          ip_set = object({
            definition = set(string)
          })
          key = string
        })))
        port_sets = optional(list(object({
          key = string
          port_set = object({
            definition = set(string)
          })
        })))
      }))
      rules_source = object({
        rules_source_list = optional(object({
          generated_rules_type = string
          target_types         = set(string)
          targets              = set(string)
        }))
        rules_string = optional(string)
        stateful_rule = optional(list(object({
          action = string
          header = object({
            destination      = string
            destination_port = string
            direction        = string
            protocol         = string
            source           = string
            source_port      = string
          })
          rule_option = list(object({
            keyword  = string
            settings = optional(set(string))
          }))
        })))
        stateless_rules_and_custom_actions = optional(object({
          custom_action = optional(list(object({
            action_definition = object({
              publish_metric_action = object({
                dimension = list(object({
                  value = string
                }))
              })
            })
            action_name = string
          })))
          stateless_rule = list(object({
            priority = number
            rule_definition = object({
              actions = set(string)
              match_attributes = object({
                destination = optional(list(object({
                  address_definition = string
                })))
                destination_port = optional(list(object({
                  from_port = number
                  to_port   = optional(number)
                })))
                protocols = optional(set(number))
                source = optional(list(object({
                  address_definition = string
                })))
                source_port = optional(list(object({
                  from_port = number
                  to_port   = optional(number)
                })))
                tcp_flag = optional(list(object({
                  flags = set(string)
                  masks = optional(set(string))
                })))
              })
            })
          }))
        }))
      })
      stateful_rule_options = optional(object({
        rule_order = string
      }))
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.networkfirewall_rule_groups : (
        v.rule_group == null || (v.rule_group.reference_sets == null || (v.rule_group.reference_sets.ip_set_references == null || (length(v.rule_group.reference_sets.ip_set_references) <= 5)))
      )
    ])
    error_message = "Each ip_set_references list must contain at most 5 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.networkfirewall_rule_groups : (
        v.rule_group == null || (v.rule_group.reference_sets == null || (v.rule_group.reference_sets.ip_set_references == null || alltrue([for item in v.rule_group.reference_sets.ip_set_references : (length(item.ip_set_reference) >= 1)])))
      )
    ])
    error_message = "Each ip_set_reference list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.networkfirewall_rule_groups : (
        v.rule_group == null || (v.rule_group.rules_source.stateful_rule == null || alltrue([for item in v.rule_group.rules_source.stateful_rule : (length(item.rule_option) >= 1)]))
      )
    ])
    error_message = "Each rule_option list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.networkfirewall_rule_groups : (
        v.rule_group == null || (v.rule_group.rules_source.stateless_rules_and_custom_actions == null || (v.rule_group.rules_source.stateless_rules_and_custom_actions.custom_action == null || alltrue([for item in v.rule_group.rules_source.stateless_rules_and_custom_actions.custom_action : (length(item.action_definition.publish_metric_action.dimension) >= 1)])))
      )
    ])
    error_message = "Each dimension list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.networkfirewall_rule_groups : (
        v.rule_group == null || (v.rule_group.rules_source.stateless_rules_and_custom_actions == null || (length(v.rule_group.rules_source.stateless_rules_and_custom_actions.stateless_rule) >= 1))
      )
    ])
    error_message = "Each stateless_rule list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.networkfirewall_rule_groups : (
        v.rule_group == null || (v.rule_group.rules_source.stateless_rules_and_custom_actions == null || (v.rule_group.rules_source.stateless_rules_and_custom_actions.custom_action == null || alltrue([for item in v.rule_group.rules_source.stateless_rules_and_custom_actions.custom_action : (can(regex("^[0-9A-Za-z]+$", item.action_name)))])))
      )
    ])
    error_message = "must contain only alphanumeric characters"
  }
  # Note: 16 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

