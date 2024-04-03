variable "name" {
  type        = string
  description = "The name of the repository."

  validation {
    condition     = length(var.name) > 0
    error_message = "Must not be empty"
  }
}

variable "description" {
  type        = string
  description = "A description of the repository"
  default     = null
}

variable "topics" {
  type        = list(string)
  description = "The list of topics of the repository."
  default     = []
}

variable "is_template" {
  type        = bool
  description = "Whether the repository is a template."
  default     = false
}

variable "visibility" {
  type        = string
  description = "The visibility of the repository."
  default     = "private"

  validation {
    condition     = contains(["private", "public"], var.visibility)
    error_message = "Must be one of 'private', 'public'."
  }
}

variable "auto_init" {
  type        = bool
  description = "Automatically create the default branch."
  default     = true
}

variable "has_downloads" {
  type        = bool
  description = "Whether the repository has downloads."
  default     = false
}

variable "has_issues" {
  type        = bool
  description = "Whether the repository has issues."
  default     = false
}

variable "has_discussions" {
  type        = bool
  description = "Whether the repository has discussions."
  default     = false
}

variable "has_projects" {
  type        = bool
  description = "Whether the repository has projects."
  default     = false
}

variable "has_wiki" {
  type        = bool
  description = "Whether the repository has wiki."
  default     = false
}

variable "homepage_url" {
  type        = string
  description = "The URL of the repository's homepage."
  default     = null
}

variable "allow_merge_commit" {
  type        = bool
  description = "Whether to allow merge commits."
  default     = true
}

variable "allow_squash_merge" {
  type        = bool
  description = "Whether to allow squash merges."
  default     = true
}

variable "allow_rebase_merge" {
  type        = bool
  description = "Whether to allow rebase merges."
  default     = true
}

variable "allow_auto_merge" {
  type        = bool
  description = "Whether to allow auto-merges."
  default     = false
}

variable "allow_update_branch" {
  type        = bool
  description = "Whether to allow update branches."
  default     = true
}

variable "squash_merge_commit_title" {
  type        = string
  description = "The title of the merge commit."
  default     = "PR_TITLE"
}

variable "squash_merge_commit_message" {
  type        = string
  description = "The message of the merge commit."
  default     = "PR_BODY"
}

variable "merge_commit_title" {
  type        = string
  description = "The title of the merge commit."
  default     = "PR_TITLE"
}

variable "merge_commit_message" {
  type        = string
  description = "The message of the merge commit."
  default     = "PR_BODY"
}

variable "delete_branch_on_merge" {
  type        = bool
  description = "Whether to delete the branch on merge."
  default     = true
}

variable "license_template" {
  type        = string
  description = "The license template of the repository."
  default     = null
}

variable "archive_on_destroy" {
  type        = bool
  description = "Whether to archive the repository on destroy."
  default     = true
}

variable "web_commit_signoff_required" {
  type        = bool
  description = "Whether to require signed commits."
  default     = false
}

variable "ignore_vulnerability_alerts_during_read" {
  type        = bool
  description = "Whether to ignore vulnerability alerts during read."
  default     = true
}

variable "vulnerability_alerts" {
  type        = string
  description = "Whether to enable vulnerability alerts."
  default     = true
}

variable "template" {
  type = object({
    owner                = string
    repository           = any
    include_all_branches = bool
  })

  description = "Template repository settings object `github_repository`."
  default     = null
}

variable "pages" {
  type = object({
    source = object({
      branch = string
      path   = string
    })

    build_type = string
    cname      = string
  })

  description = "Pages repository settings object `github_repository`."
  default     = null
}

variable "security_and_analysis" {
  type = object({
    advanced_security = object({
      status = string
    })
    secret_scanning = object({
      status = string
    })
    secret_scanning_push_protection = object({
      status = string
    })
  })

  description = "Security and analysis repository settings object `github_repository`."
  default = {
    advanced_security = {
      status = "enabled"
    }
    secret_scanning = {
      status = "enabled"
    }
    secret_scanning_push_protection = {
      status = "enabled"
    }
  }

  validation {
    condition = (
      contains(["enabled", "disabled"], coalesce(var.security_and_analysis, { advanced_security = { status = "enabled" } }).advanced_security.status, )
    )
    error_message = "Must be enabled or disabled"
  }

  validation {
    condition = (
      contains(["enabled", "disabled"], coalesce(var.security_and_analysis, { secret_scanning = { status = "enabled" } }).secret_scanning.status)
    )
    error_message = "Must be enabled or disabled"
  }

  validation {
    condition = (
      contains(["enabled", "disabled"], coalesce(var.security_and_analysis, { secret_scanning_push_protection = { status = "enabled" } }).secret_scanning_push_protection.status)
    )
    error_message = "Must be enabled or disabled"
  }
}
