# The single source of truth: every repository owned by gitt510.
#
#   visibility        - "public" or "private"
#   archived          - repository is read-only
#   branch_protection - create a main ruleset (public repos only; the free
#                       plan rejects rulesets on private repos)
#   status_checks     - required status check contexts for the ruleset
locals {
  repo_defaults = {
    visibility        = "private"
    archived          = false
    branch_protection = false
    status_checks     = []
  }

  repo_overrides = {
    ".github"           = { visibility = "public" }
    "agent-settings"    = {}
    "agent-skills"      = { visibility = "public" }
    "articles"          = {}
    "bibles"            = {}
    "dotfiles"          = {}
    "gh-radar"          = {}
    "gitt510"           = { visibility = "public" }
    "github-automation" = {}
    "github-iac"        = {}
    "kakeibo"           = {}
    "keel"              = {}
    "kura"              = { visibility = "public", branch_protection = true, status_checks = ["test"] }
    "lexicon"           = {}
    "life"              = {}
    "moat"              = {}
    "nabu"              = { visibility = "public", branch_protection = true }
    "notes"             = {}
    "nuska"             = { visibility = "public", branch_protection = true }
    "resume"            = {}
    "shiori"            = {}
    "slides"            = {}
    "sscreener"         = {}
    "stk"               = {}
    "sumika"            = {}
    "yagura"            = { visibility = "public" }
  }

  repos = {
    for name, overrides in local.repo_overrides :
    name => merge(local.repo_defaults, overrides)
  }
}
