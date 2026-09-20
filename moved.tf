# Repositories renamed on GitHub. GitHub redirects the old name to the new one,
# so without these blocks a plan would try to rename them back.
moved {
  from = github_repository.this["dopagaki-numpre"]
  to   = github_repository.this["stk"]
}

moved {
  from = github_repository.this["shukuchi"]
  to   = github_repository.this["nuska"]
}
