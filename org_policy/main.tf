resource "google_org_policy_policy" "policy" {
  for_each = { for entry in var.policies : entry.policy.name => entry.policy }

  parent = var.parent
  name   = "${var.parent}/policies/${each.key}"

  spec {
    inherit_from_parent = try(each.value.spec.inheritFromParent, null)

    dynamic "rules" {
      for_each = try(each.value.spec.rules, [])
      content {
        enforce   = try(rules.value.enforce, null)
        allow_all = try(rules.value.allowAll, null)
        deny_all  = try(rules.value.denyAll, null)
        dynamic "values" {
          for_each = try(rules.value.values, null) == null ? [] : [1]
          content {
            allowed_values = try(rules.value.vaules.allowedValues, null)
            denied_values  = try(rules.value.values.deniedValues, null)
          }
        }
      }
    }
  }
}
