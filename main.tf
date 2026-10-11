resource "aws_networkfirewall_rule_group" "networkfirewall_rule_groups" {
  for_each = var.networkfirewall_rule_groups

  capacity    = each.value.capacity
  name        = each.value.name
  type        = each.value.type
  description = each.value.description
  region      = each.value.region
  rules       = each.value.rules
  tags        = each.value.tags
  tags_all    = each.value.tags_all

  dynamic "encryption_configuration" {
    for_each = each.value.encryption_configuration != null ? [each.value.encryption_configuration] : []
    content {
      key_id = encryption_configuration.value.key_id
      type   = encryption_configuration.value.type
    }
  }

  dynamic "rule_group" {
    for_each = each.value.rule_group != null ? [each.value.rule_group] : []
    content {
      dynamic "reference_sets" {
        for_each = rule_group.value.reference_sets != null ? [rule_group.value.reference_sets] : []
        content {
          dynamic "ip_set_references" {
            for_each = reference_sets.value.ip_set_references != null ? reference_sets.value.ip_set_references : []
            content {
              dynamic "ip_set_reference" {
                for_each = ip_set_references.value.ip_set_reference
                content {
                  reference_arn = ip_set_reference.value.reference_arn
                }
              }
              key = ip_set_references.value.key
            }
          }
        }
      }
      dynamic "rule_variables" {
        for_each = rule_group.value.rule_variables != null ? [rule_group.value.rule_variables] : []
        content {
          dynamic "ip_sets" {
            for_each = rule_variables.value.ip_sets != null ? rule_variables.value.ip_sets : []
            content {
              ip_set {
                definition = ip_sets.value.ip_set.definition
              }
              key = ip_sets.value.key
            }
          }
          dynamic "port_sets" {
            for_each = rule_variables.value.port_sets != null ? rule_variables.value.port_sets : []
            content {
              key = port_sets.value.key
              port_set {
                definition = port_sets.value.port_set.definition
              }
            }
          }
        }
      }
      rules_source {
        dynamic "rules_source_list" {
          for_each = rule_group.value.rules_source.rules_source_list != null ? [rule_group.value.rules_source.rules_source_list] : []
          content {
            generated_rules_type = rules_source_list.value.generated_rules_type
            target_types         = rules_source_list.value.target_types
            targets              = rules_source_list.value.targets
          }
        }
        rules_string = rule_group.value.rules_source.rules_string
        dynamic "stateful_rule" {
          for_each = rule_group.value.rules_source.stateful_rule != null ? rule_group.value.rules_source.stateful_rule : []
          content {
            action = stateful_rule.value.action
            header {
              destination      = stateful_rule.value.header.destination
              destination_port = stateful_rule.value.header.destination_port
              direction        = stateful_rule.value.header.direction
              protocol         = stateful_rule.value.header.protocol
              source           = stateful_rule.value.header.source
              source_port      = stateful_rule.value.header.source_port
            }
            dynamic "rule_option" {
              for_each = stateful_rule.value.rule_option
              content {
                keyword  = rule_option.value.keyword
                settings = rule_option.value.settings
              }
            }
          }
        }
        dynamic "stateless_rules_and_custom_actions" {
          for_each = rule_group.value.rules_source.stateless_rules_and_custom_actions != null ? [rule_group.value.rules_source.stateless_rules_and_custom_actions] : []
          content {
            dynamic "custom_action" {
              for_each = stateless_rules_and_custom_actions.value.custom_action != null ? stateless_rules_and_custom_actions.value.custom_action : []
              content {
                action_definition {
                  publish_metric_action {
                    dynamic "dimension" {
                      for_each = custom_action.value.action_definition.publish_metric_action.dimension
                      content {
                        value = dimension.value.value
                      }
                    }
                  }
                }
                action_name = custom_action.value.action_name
              }
            }
            dynamic "stateless_rule" {
              for_each = stateless_rules_and_custom_actions.value.stateless_rule
              content {
                priority = stateless_rule.value.priority
                rule_definition {
                  actions = stateless_rule.value.rule_definition.actions
                  match_attributes {
                    dynamic "destination" {
                      for_each = stateless_rule.value.rule_definition.match_attributes.destination != null ? stateless_rule.value.rule_definition.match_attributes.destination : []
                      content {
                        address_definition = destination.value.address_definition
                      }
                    }
                    dynamic "destination_port" {
                      for_each = stateless_rule.value.rule_definition.match_attributes.destination_port != null ? stateless_rule.value.rule_definition.match_attributes.destination_port : []
                      content {
                        from_port = destination_port.value.from_port
                        to_port   = destination_port.value.to_port
                      }
                    }
                    protocols = stateless_rule.value.rule_definition.match_attributes.protocols
                    dynamic "source" {
                      for_each = stateless_rule.value.rule_definition.match_attributes.source != null ? stateless_rule.value.rule_definition.match_attributes.source : []
                      content {
                        address_definition = source.value.address_definition
                      }
                    }
                    dynamic "source_port" {
                      for_each = stateless_rule.value.rule_definition.match_attributes.source_port != null ? stateless_rule.value.rule_definition.match_attributes.source_port : []
                      content {
                        from_port = source_port.value.from_port
                        to_port   = source_port.value.to_port
                      }
                    }
                    dynamic "tcp_flag" {
                      for_each = stateless_rule.value.rule_definition.match_attributes.tcp_flag != null ? stateless_rule.value.rule_definition.match_attributes.tcp_flag : []
                      content {
                        flags = tcp_flag.value.flags
                        masks = tcp_flag.value.masks
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
      dynamic "stateful_rule_options" {
        for_each = rule_group.value.stateful_rule_options != null ? [rule_group.value.stateful_rule_options] : []
        content {
          rule_order = stateful_rule_options.value.rule_order
        }
      }
    }
  }
}

