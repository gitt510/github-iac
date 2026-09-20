resource "github_repository" "this" {
  for_each = local.repos

  name       = each.key
  visibility = "public"
  archived   = false

  # Deleting from locals archives the repo instead of destroying it.
  archive_on_destroy = true

  lifecycle {
    # Only name / visibility / archived are managed here. Everything else
    # stays owned by the GitHub UI until it graduates into locals.
    ignore_changes = [
      description,
      homepage_url,
      topics,
      has_issues,
      has_projects,
      has_wiki,
      has_discussions,
      is_template,
      allow_merge_commit,
      allow_squash_merge,
      allow_rebase_merge,
      allow_auto_merge,
      allow_update_branch,
      delete_branch_on_merge,
      merge_commit_title,
      merge_commit_message,
      squash_merge_commit_title,
      squash_merge_commit_message,
      vulnerability_alerts,
      web_commit_signoff_required,
      security_and_analysis,
      pages,
    ]
  }
}

resource "github_repository_ruleset" "main" {
  for_each = {
    for name, repo in local.repos :
    name => repo
    if repo.branch_protection
  }

  name        = "main"
  repository  = github_repository.this[each.key].name
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = ["~DEFAULT_BRANCH"]
      exclude = []
    }
  }

  rules {
    deletion                = true
    non_fast_forward        = true
    required_linear_history = true

    pull_request {
      required_approving_review_count = 0
    }

    dynamic "required_status_checks" {
      for_each = length(each.value.status_checks) > 0 ? [1] : []
      content {
        dynamic "required_check" {
          for_each = each.value.status_checks
          content {
            context = required_check.value
          }
        }
      }
    }
  }
}
