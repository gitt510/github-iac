# Every public repository owned by gitt510. Private repositories are not
# managed here: the free plan rejects rulesets on them, and they change too
# freely to be worth a plan cycle. Making a repository public starts by
# adding it to this list.
#
#   protect_main    - create the "main" ruleset: PRs only, no deletion, no force push, linear history
#   required_checks - status check contexts the "checks" ruleset requires; none, no ruleset
locals {
  repo_defaults = {
    protect_main    = false
    required_checks = []
  }

  repo_overrides = {
    ".github"      = {}
    "agent-skills" = {}
    "github-iac"   = { protect_main = true }
    "gitt510"      = {}
    "kura"         = { protect_main = true, required_checks = ["test"] }
    "nabu"         = { protect_main = true }
    "nuska"        = { protect_main = true }
    "yagura"       = {}
  }

  repos = {
    for name, overrides in local.repo_overrides :
    name => merge(local.repo_defaults, overrides)
  }
}
