_default:
    @just --list

# Preview changes against GitHub; extra flags pass through
plan *args:
    GITHUB_TOKEN=$(gh auth token) terraform plan {{args}}

# Apply the declared settings to GitHub; extra flags pass through
apply *args:
    GITHUB_TOKEN=$(gh auth token) terraform apply {{args}}

# Show the declared repository ledger as a table
show:
    @terraform output -json repos | jq -r '["REPO", "VISIBILITY", "MAIN_RULESET", "ARCHIVED"], (to_entries | sort_by(.key)[] | [.key, .value.visibility, (.value.main_ruleset | tostring), (.value.archived | tostring)]) | @tsv' | column -t | awk 'NR==1 {print "\033[1m" $0 "\033[0m"; next} {gsub(/public/, "\033[32m&\033[0m"); gsub(/private/, "\033[2m&\033[0m"); gsub(/true/, "\033[33m&\033[0m"); gsub(/false/, "\033[2m&\033[0m"); print}'
