_default:
    @just --list

# Secrets are injected per invocation from 1Password (see op.env); nothing is
# stored on disk or in the shell.
tf := "op run --env-file=op.env -- terraform"

# Initialize providers and the HCP Terraform backend
init *args:
    {{tf}} init {{args}}

# Preview changes against GitHub; extra flags pass through
plan *args:
    {{tf}} plan {{args}}

# Apply the declared settings to GitHub; extra flags pass through
apply *args:
    {{tf}} apply {{args}}

# Check formatting and validate the configuration
check:
    terraform fmt -check -recursive
    {{tf}} validate

# Show the declared repository ledger as a table
show:
    @{{tf}} output -json repos | jq -r '["REPO", "MAIN_RULESET"], (to_entries | sort_by(.key)[] | [.key, (.value.main_ruleset | tostring)]) | @tsv' | column -t
