output "repos" {
  description = "The declared public repositories."
  value = {
    for name, repo in local.repos :
    name => {
      main_ruleset    = repo.protect_main
      required_checks = repo.required_checks
    }
  }
}
