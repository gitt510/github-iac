terraform {
  required_version = ">= 1.5"

  cloud {
    organization = "gitt510"

    workspaces {
      name = "github-iac"
    }
  }

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

provider "github" {
  owner = "gitt510"
}
