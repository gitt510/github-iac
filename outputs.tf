output "repos" {
  description = "The declared repository ledger."
  value = {
    for name, repo in local.repos :
    name => {
      visibility = repo.visibility
      archived   = repo.archived
      main_ruleset = repo.branch_protection && repo.visibility == "public"
    }
  }
}
