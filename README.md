# github-iac

Declares every public repository of the `gitt510` account in Terraform and applies it to GitHub.

## Behavior

- after `just apply`, the public repositories of `gitt510` are exactly the ones listed in `locals.tf`
- a repository removed from the list is archived on GitHub, not deleted
- settings edited in the GitHub UI other than name, visibility and archived state survive `just apply`

## Stack

| Layer | Tool |
| --- | --- |
| Configuration | Terraform, `integrations/github` provider |
| State | HCP Terraform, organization `gitt510`, workspace `github-iac` |
| Secrets | 1Password via `op run` |
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
