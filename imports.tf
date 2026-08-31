# One-time imports of pre-existing resources. Safe to keep; applied imports
# become no-ops. Remove once every resource is in state.
import {
  for_each = local.repos
  to       = github_repository.this[each.key]
  id       = each.key
}

import {
  to = github_repository_ruleset.main["kura"]
  id = "kura:20100094"
}
