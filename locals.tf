# Every public repository owned by gitt510. Private repositories are not
# managed here: the free plan rejects rulesets on them, and they change too
# freely to be worth a plan cycle. Making a repository public starts by
# adding it to this list.
#
#   branch_protection - create a main ruleset
#   status_checks     - required status check contexts for the ruleset
locals {
  repo_defaults = {
    branch_protection = false
    status_checks     = []
  }

  repo_overrides = {
    ".github"      = {}
    "agent-skills" = {}
    "gitt510"      = {}
    "kura"         = { branch_protection = true, status_checks = ["test"] }
    "nabu"         = { branch_protection = true }
    "nuska"        = { branch_protection = true }
    "yagura"       = {}
  }

  repos = {
    for name, overrides in local.repo_overrides :
    name => merge(local.repo_defaults, overrides)
  }
}
