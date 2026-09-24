# github-iac

Declares every public repository of the `gitt510` account in Terraform and applies it to GitHub.

## Behavior

- a repository is public when, and only when, it is listed in `repo_overrides` in `locals.tf`
- removing a repository from the list archives it on GitHub; nothing is deleted
- for each listed repository Terraform owns name, visibility and archived state; every other setting is left to the GitHub UI
- a repository with `branch_protection = true` gets a `main` ruleset on its default branch: no deletion, no force push, linear history, changes land through a pull request
- `status_checks` lists the check contexts that ruleset requires before merge
- private repositories are not managed

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
