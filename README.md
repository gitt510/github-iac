# github-iac

Declares every public repository of the `gitt510` account in Terraform and applies it to GitHub.

## Behavior

- after `just apply`, the public repositories of `gitt510` are exactly the ones listed in `locals.tf`
- a repository removed from the list is archived on GitHub, not deleted
- description, topics, merge options and other settings edited in the GitHub UI survive `just apply`
- a repository listed with `branch_protection = true` rejects direct pushes, force pushes and deletion on its default branch; changes land through a pull request, and `status_checks` names the checks that must pass first
- private repositories are unchanged by `just apply`

## Stack

| Layer | Tool |
| --- | --- |
| Configuration | Terraform 1.16 (mise), `integrations/github` provider 6.x |
| State | HCP Terraform, organization `gitt510`, workspace `github-iac` |
| Secrets | 1Password via `op run`; nothing stored on disk |
| Task runner | just |

## Requirements

- `mise` and `op` (1Password CLI) installed and signed in
- 1Password items referenced in `op.env`: a GitHub token with repository administration and an HCP Terraform token

## Usage

```bash
just init    # providers + HCP Terraform backend
just plan    # preview against GitHub
just apply   # apply the declared settings
just check   # terraform fmt -check + validate
just show    # table of declared repositories and their main ruleset
```

## Making a repository public

1. add the repository to `repo_overrides` in `locals.tf`
2. import it: `op run --env-file=op.env -- terraform import 'github_repository.this["<name>"]' <name>`
3. `just plan`, then `just apply`
