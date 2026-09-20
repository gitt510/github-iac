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
    @{{tf}} output -json repos | jq -r '["REPO", "VISIBILITY", "MAIN_RULESET", "ARCHIVED"], (to_entries | sort_by(.key)[] | [.key, .value.visibility, (.value.main_ruleset | tostring), (.value.archived | tostring)]) | @tsv' | column -t | awk 'NR==1 {print "\033[1m" $0 "\033[0m"; next} {gsub(/public/, "\033[32m&\033[0m"); gsub(/private/, "\033[2m&\033[0m"); gsub(/true/, "\033[33m&\033[0m"); gsub(/false/, "\033[2m&\033[0m"); print}'
