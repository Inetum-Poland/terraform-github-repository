variable "github_repository" {
  type = object({
    name        = string
    description = optional(string)
    topics      = optional(list(string), [])
    is_template = optional(bool, false)
    visibility  = optional(string, "private")
    auto_init   = optional(bool, true)

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
    squash_merge_commit_title   = optional(string, "PR_TITLE")
    squash_merge_commit_message = optional(string, "PR_BODY")
    merge_commit_title          = optional(string, "PR_TITLE")
    merge_commit_message        = optional(string, "PR_BODY")
    delete_branch_on_merge      = optional(bool, true)

    license_template                        = optional(string)
    archive_on_destroy                      = optional(bool, true)
    web_commit_signoff_required             = optional(bool, false)
    vulnerability_alerts                    = optional(bool, true)
    ignore_vulnerability_alerts_during_read = optional(bool, true)

    template = optional(object({
      owner                = string
      repository           = any
      include_all_branches = bool
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

variable "github_branch" {
  type = list(string)

  description = "Branch repository settings object `github_branch`."

  default = ["main"]
}

variable "github_branch_default" {
  type = string

  description = "Default branch repository settings object `github_branch_default`."

  default = "main"
}

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
      contexts = optional(list(string), ["pre_commit"])
      strict   = optional(bool, true)
    }), {})
  }))

  description = "Branch protection repository settings object `github_branch_protection`."

  default = { main = { pattern = "main" } }
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
