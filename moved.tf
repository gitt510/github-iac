# nuska was imported under its old name. GitHub redirects the old name to the
# new one, so without this block a plan would try to rename it back.
moved {
  from = github_repository.this["shukuchi"]
  to   = github_repository.this["nuska"]
}
