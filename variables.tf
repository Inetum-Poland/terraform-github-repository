variable "github_repository" {
  type = object({
    name        = string
    description = optional(string)
    topics      = optional(list(string), [])
    is_template = optional(bool, false)
    visibility  = optional(string, "private")

    # auto_init   = optional(bool, true)

    has_downloads   = optional(bool, false)
    has_issues      = optional(bool, false)
    has_projects    = optional(bool, false)
    has_wiki        = optional(bool, false)
    has_discussions = optional(bool, false)
    homepage_url    = optional(string)

    allow_merge_commit          = optional(bool, true)
    allow_squash_merge          = optional(bool, true)
    allow_rebase_merge          = optional(bool, true)
    allow_auto_merge            = optional(bool, false)
    allow_update_branch         = optional(bool, true)
    squash_merge_commit_title   = optional(string, null) # "PR_TITLE"
    squash_merge_commit_message = optional(string, null) # "PR_BODY"
    merge_commit_title          = optional(string, null) # "PR_TITLE"
    merge_commit_message        = optional(string, null) # "PR_BODY"
    delete_branch_on_merge      = optional(bool, true)

    # license_template = optional(string)

    archive_on_destroy                      = optional(bool, true)
    web_commit_signoff_required             = optional(bool, false)
    vulnerability_alerts                    = optional(bool, true)
    ignore_vulnerability_alerts_during_read = optional(bool, true)

    template = optional(object({
      owner                = string
      repository           = any
      include_all_branches = optional(bool, false)
    }), null)

    pages = optional(object({
      source = object({
        branch = string
        path   = string
      })
      build_type = string
      cname      = string
    }), null)

    security_and_analysis = optional(object({
      advanced_security = optional(object({
        status = optional(string, "enabled")
      }), {})
      secret_scanning = optional(object({
        status = optional(string, "enabled")
      }), {})
      secret_scanning_push_protection = optional(object({
        status = optional(string, "enabled")
      }), {})
    }), {})
  })

  description = "Repository settings object `github_repository`."
}

variable "github_branch_default" {
  type = string

  description = "Default branch repository settings object `github_branch_default`."

  default = null
}

# TO BE DEPRECATED
variable "github_branch_protection" {
  type = map(object({
    pattern = string

    allows_deletions                = optional(bool, false)
    allows_force_pushes             = optional(bool, false)
    enforce_admins                  = optional(bool, false)
    force_push_bypassers            = optional(list(string), [])
    lock_branch                     = optional(bool, false)
    require_conversation_resolution = optional(bool, true)
    require_signed_commits          = optional(bool, false)
    required_linear_history         = optional(bool, false)

    required_pull_request_reviews = optional(object({
      dismiss_stale_reviews           = optional(bool, true)
      require_code_owner_reviews      = optional(bool, true)
      require_last_push_approval      = optional(bool, true)
      required_approving_review_count = optional(number, 1)
      restrict_dismissals             = optional(bool, false)
    }), {})

    required_status_checks = optional(object({
      contexts = optional(list(string), [])
      strict   = optional(bool, true)
    }), {})
  }))

  description = "Branch protection repository settings object `github_branch_protection`."

  default = {}
}

variable "github_repository_ruleset" {
  type = map(object({
    enforcement = string
    # name        = string
    target = string
    # repository  = string

    rules = list(object({
      branch_name_pattern = optional(object({
        operator = string
        pattern  = string
        name     = optional(string, null)
        negate   = optional(bool, false)
      }), null)

      commit_author_email_pattern = optional(object({
        operator = string
        pattern  = string
        name     = optional(string, null)
        negate   = optional(bool, false)
      }), null)

      commit_message_pattern = optional(object({
        operator = string
        pattern  = string
        name     = optional(string, null)
        negate   = optional(bool, false)
      }), null)

      committer_email_pattern = optional(object({
        operator = string
        pattern  = string
        name     = optional(string, null)
        negate   = optional(bool, false)
      }), null)

      creation         = optional(bool, false)
      deletion         = optional(bool, false)
      non_fast_forward = optional(bool, false)

      pull_request = optional(object({
        dismiss_stale_reviews_on_push     = optional(bool, false)
        require_code_owner_reviews        = optional(bool, false)
        require_last_push_approval        = optional(bool, false)
        required_approving_review_count   = optional(number, 0)
        required_review_thread_resolution = optional(bool, false)
      }), null)

      required_deployments = optional(object({
        required_deployment_environments = list(string)
      }), null)

      required_linear_history = optional(bool, false)
      required_signatures     = optional(bool, false)

      required_status_checks = optional(object({
        required_check = list(object({
          context        = string
          integration_id = optional(number, null)
        }))

        strict_required_status_checks_policy = optional(bool, false)
      }), null)

      tag_name_pattern = optional(object({
        operator = string
        pattern  = string
        name     = optional(string, null)
        negate   = optional(bool, false)
      }), null)

      update                        = optional(bool, false)
      update_allows_fetch_and_merge = optional(bool, false)
    }))

    bypass_actors = optional(list(object({
      actor_id    = number
      actor_type  = optional(string, null)
      bypass_mode = optional(string, null)
    })), null)

    conditions = optional(object({
      ref_name = optional(object({
        exclude = optional(list(string), [])
        include = optional(list(string), [])
      }), null)
    }), null)
  }))

  description = "Branch protection repository settings object `github_branch_protection`."

  default = {}
}

variable "github_actions_variable" {
  type = map(string)

  description = "Actions variable repository settings object `github_actions_variable`."

  default = {}
}

variable "github_actions_secret" {
  type = map(string)

  description = "Actions secret repository settings object `github_actions_secret`."

  default = {}
}

variable "github_dependabot_secret" {
  type = map(string)

  description = "Dependabot secret repository settings object `github_dependabot_secret`."

  default = {}
}

variable "github_issue_label" {
  type = map(object({
    name        = string
    color       = string
    description = optional(string, null)
  }))

  description = "Issue labels repository settings object `github_issue_label`."

  default = {}
}
