terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

#trivy:ignore:AVD-GIT-0001 No sensitive information
#trivy:ignore:AVD-GIT-0003 This is configurable
resource "github_repository" "repository" {
  name        = var.github_repository.name
  description = var.github_repository.description
  topics      = var.github_repository.topics
  is_template = var.github_repository.is_template
  visibility  = var.github_repository.visibility

  # auto_init   = var.github_repository.auto_init

  has_discussions = var.github_repository.has_discussions
  has_downloads   = var.github_repository.has_downloads
  has_issues      = var.github_repository.has_issues
  has_projects    = var.github_repository.has_projects
  has_wiki        = var.github_repository.has_wiki
  homepage_url    = var.github_repository.homepage_url

  allow_merge_commit          = var.github_repository.allow_merge_commit
  allow_squash_merge          = var.github_repository.allow_squash_merge
  allow_rebase_merge          = var.github_repository.allow_rebase_merge
  allow_auto_merge            = var.github_repository.allow_auto_merge
  allow_update_branch         = var.github_repository.allow_update_branch
  squash_merge_commit_title   = var.github_repository.squash_merge_commit_title
  squash_merge_commit_message = var.github_repository.squash_merge_commit_message
  merge_commit_title          = var.github_repository.merge_commit_title
  merge_commit_message        = var.github_repository.merge_commit_message
  delete_branch_on_merge      = var.github_repository.delete_branch_on_merge

  # license_template = var.github_repository.license_template

  archive_on_destroy                      = var.github_repository.archive_on_destroy
  web_commit_signoff_required             = var.github_repository.web_commit_signoff_required
  vulnerability_alerts                    = var.github_repository.vulnerability_alerts
  ignore_vulnerability_alerts_during_read = var.github_repository.ignore_vulnerability_alerts_during_read # true

  dynamic "template" {
    for_each = var.github_repository.template != null ? [1] : []

    content {
      owner                = var.github_repository.template.owner
      repository           = var.github_repository.template.repository
      include_all_branches = var.github_repository.template.include_all_branches
    }
  }

  dynamic "pages" {
    for_each = var.github_repository.pages != null ? [1] : []

    content {
      build_type = var.github_repository.pages.build_type
      cname      = var.github_repository.pages.cname


      dynamic "source" {
        for_each = var.github_repository.pages.source != null ? [1] : []

        content {
          branch = var.github_repository.pages.source.branch
          path   = var.github_repository.pages.source.path
        }
      }
    }
  }

  dynamic "security_and_analysis" {
    for_each = var.github_repository.visibility == "public" ? [1] : []

    content {
      # dynamic "advanced_security" {
      #   for_each = var.github_repository.visibility == "public" ? [1] : []

      #   content {
      #     status = var.github_repository.security_and_analysis.advanced_security.status
      #   }
      # }

      dynamic "secret_scanning" {
        for_each = var.github_repository.visibility == "public" ? [1] : []

        content {
          status = var.github_repository.security_and_analysis.secret_scanning.status
        }
      }

      dynamic "secret_scanning_push_protection" {
        for_each = var.github_repository.visibility == "public" ? [1] : []

        content {
          status = var.github_repository.security_and_analysis.secret_scanning_push_protection.status
        }
      }
    }
  }

  lifecycle {
    precondition {
      condition     = length(var.github_repository.name) > 0
      error_message = "Variable `name` must not be empty."
    }

    precondition {
      condition     = can(regex("^\\.?[0-9A-Za-z-]+$", var.github_repository.name))
      error_message = "Variable `name` does not meet naming convention standard."
    }

    precondition {
      condition     = contains(["private", "public"], var.github_repository.visibility)
      error_message = "Variable `visibility` must be one of \"private\", \"public\"."
    }

    # precondition {
    #   condition     = (var.github_repository.auto_init == true && (
    #                     (var.github_repository.visibility == "private" && var.github_repository.license_template == null) ||
    #                     (var.github_repository.visibility == "public" && var.github_repository.license_template != null)
    #                   ))
    #   error_message = "Variable `license_template` must be set accordingly while `auto_init` is \"true\"."
    # }

    precondition {
      condition = (
        var.github_repository.allow_squash_merge == false && (
          var.github_repository.squash_merge_commit_title == null &&
        var.github_repository.squash_merge_commit_message == null) ||
      var.github_repository.allow_squash_merge == true)
      error_message = "Variables `squash_merge_commit_title` and `squash_merge_commit_message` must be set to \"null\" when `allow_squash_merge` is \"false\"."
    }

    precondition {
      condition = (
        var.github_repository.allow_merge_commit == false && (
          var.github_repository.merge_commit_title == null &&
        var.github_repository.merge_commit_message == null) ||
      var.github_repository.allow_merge_commit == true)
      error_message = "Variables `merge_commit_title` and `merge_commit_message` must be set to \"null\" when `allow_merge_commit` is \"false\"."
    }

    precondition {
      condition = (
        var.github_repository.allow_rebase_merge == false && (
          var.github_repository.merge_commit_title == null &&
        var.github_repository.merge_commit_message == null) ||
      var.github_repository.allow_rebase_merge == true)
      error_message = "Variables `merge_commit_title` and `merge_commit_message` must be set to \"null\" when `allow_rebase_merge` is \"false\"."
    }

    precondition {
      condition     = contains(["enabled", "disabled"], coalesce(var.github_repository.security_and_analysis, { advanced_security = { status = "enabled" } }).advanced_security.status, )
      error_message = "Variable `advanced_security` must be \"enabled\" or \"disabled\"."
    }

    precondition {
      condition     = contains(["enabled", "disabled"], coalesce(var.github_repository.security_and_analysis, { secret_scanning = { status = "enabled" } }).secret_scanning.status)
      error_message = "Variable `secret_scanning` must be \"enabled\" or \"disabled\"."
    }

    precondition {
      condition     = contains(["enabled", "disabled"], coalesce(var.github_repository.security_and_analysis, { secret_scanning_push_protection = { status = "enabled" } }).secret_scanning_push_protection.status)
      error_message = "Variable `secret_scanning_push_protection` must be \"enabled\" or \"disabled\"."
    }
  }
}

resource "github_branch_default" "branch" {
  count = var.github_branch_default != null ? 1 : 0

  repository = github_repository.repository.id
  branch     = var.github_branch_default

  depends_on = [github_repository.repository]
}

# TO BE DEPRECATED
#trivy:ignore:AVD-GIT-0004 No need to sign commits
resource "github_branch_protection" "branch" {
  for_each = var.github_branch_protection != null ? var.github_branch_protection : {}

  repository_id = github_repository.repository.id
  pattern       = each.value.pattern

  allows_deletions                = each.value.allows_deletions
  allows_force_pushes             = each.value.allows_force_pushes
  enforce_admins                  = each.value.enforce_admins
  force_push_bypassers            = each.value.force_push_bypassers
  lock_branch                     = each.value.lock_branch
  require_conversation_resolution = each.value.require_conversation_resolution
  require_signed_commits          = each.value.require_signed_commits
  required_linear_history         = each.value.required_linear_history

  dynamic "required_pull_request_reviews" {
    for_each = each.value.required_pull_request_reviews != null ? [1] : []

    content {
      dismiss_stale_reviews           = each.value.required_pull_request_reviews.dismiss_stale_reviews
      require_code_owner_reviews      = each.value.required_pull_request_reviews.require_code_owner_reviews
      require_last_push_approval      = each.value.required_pull_request_reviews.require_last_push_approval
      required_approving_review_count = each.value.required_pull_request_reviews.required_approving_review_count
      restrict_dismissals             = each.value.required_pull_request_reviews.restrict_dismissals
    }
  }

  dynamic "required_status_checks" {
    for_each = each.value.required_status_checks != null ? [1] : []

    content {
      strict   = each.value.required_status_checks.strict
      contexts = each.value.required_status_checks.contexts
    }
  }

  depends_on = [
    github_branch_default.branch,
    github_repository.repository
  ]
}

# ! Replaces for "github_branch_protection"
# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_ruleset
resource "github_repository_ruleset" "ruleset" {
  for_each = var.github_repository_ruleset != null ? var.github_repository_ruleset : {}

  name        = each.key
  enforcement = each.value.enforcement
  target      = each.value.target
  repository  = var.github_repository.name

  dynamic "rules" {
    for_each = each.value.rules
    content {
      dynamic "branch_name_pattern" {
        for_each = rules.value.branch_name_pattern != null ? [0] : []
        content {
          operator = rules.value.branch_name_pattern.operator
          pattern  = rules.value.branch_name_pattern.pattern
          name     = rules.value.branch_name_pattern.name
          negate   = rules.value.branch_name_pattern.negate
        }
      }

      dynamic "commit_author_email_pattern" {
        for_each = rules.value.commit_author_email_pattern != null ? [0] : []
        content {
          operator = rules.value.commit_author_email_pattern.operator
          pattern  = rules.value.commit_author_email_pattern.pattern
          name     = rules.value.commit_author_email_pattern.name
          negate   = rules.value.commit_author_email_pattern.negate
        }
      }

      dynamic "commit_message_pattern" {
        for_each = rules.value.commit_message_pattern != null ? [0] : []
        content {
          operator = rules.value.commit_message_pattern.operator
          pattern  = rules.value.commit_message_pattern.pattern
          name     = rules.value.commit_message_pattern.name
          negate   = rules.value.commit_message_pattern.negate
        }
      }

      dynamic "committer_email_pattern" {
        for_each = rules.value.committer_email_pattern != null ? [0] : []
        content {
          operator = rules.value.committer_email_pattern.operator
          pattern  = rules.value.committer_email_pattern.pattern
          name     = rules.value.committer_email_pattern.name
          negate   = rules.value.committer_email_pattern.negate
        }
      }

      creation         = rules.value.creation
      deletion         = rules.value.deletion
      non_fast_forward = rules.value.non_fast_forward

      dynamic "pull_request" {
        for_each = rules.value.pull_request != null ? [0] : []
        content {
          dismiss_stale_reviews_on_push = rules.value.pull_request.dismiss_stale_reviews_on_push
          # TYPO BY OWNERS
          require_code_owner_review         = rules.value.pull_request.require_code_owner_reviews
          require_last_push_approval        = rules.value.pull_request.require_last_push_approval
          required_approving_review_count   = rules.value.pull_request.required_approving_review_count
          required_review_thread_resolution = rules.value.pull_request.required_review_thread_resolution
        }
      }

      dynamic "required_deployments" {
        for_each = rules.value.required_deployments != null ? [0] : []
        content {
          required_deployment_environments = rules.value.required_deployments.required_deployment_environments
        }
      }

      required_linear_history = rules.value.required_linear_history
      required_signatures     = rules.value.required_signatures

      dynamic "required_status_checks" {
        for_each = rules.value.required_status_checks != null ? [0] : []
        content {
          dynamic "required_check" {
            for_each = rules.value.required_status_checks.required_check
            content {
              context        = required_check.value.context
              integration_id = required_check.value.integration_id
            }
          }

          strict_required_status_checks_policy = rules.value.required_status_checks.strict_required_status_checks_policy
        }
      }

      dynamic "tag_name_pattern" {
        for_each = rules.value.tag_name_pattern != null ? [0] : []
        content {
          operator = rules.value.tag_name_pattern.operator
          pattern  = rules.value.tag_name_pattern.pattern
          name     = rules.value.tag_name_pattern.name
          negate   = rules.value.tag_name_pattern.negate
        }
      }

      update                        = rules.value.update
      update_allows_fetch_and_merge = rules.value.update_allows_fetch_and_merge
    }
  }

  dynamic "bypass_actors" {
    for_each = each.value.bypass_actors
    content {
      actor_id    = bypass_actors.value.actor_id
      actor_type  = bypass_actors.value.actor_type
      bypass_mode = bypass_actors.value.bypass_mode
    }
  }

  conditions {
    ref_name {
      exclude = each.value.conditions.ref_name.exclude
      include = each.value.conditions.ref_name.include
    }
  }
}

resource "github_actions_variable" "variable" {
  for_each = var.github_actions_variable

  repository    = github_repository.repository.id
  variable_name = each.key
  value         = each.value

  depends_on = [github_repository.repository]
}

resource "github_actions_secret" "secret" {
  for_each = var.github_actions_secret

  repository      = github_repository.repository.id
  secret_name     = each.key
  encrypted_value = each.value

  depends_on = [github_repository.repository]
}

resource "github_dependabot_secret" "secret" {
  for_each = var.github_dependabot_secret

  repository      = github_repository.repository.id
  secret_name     = each.key
  encrypted_value = each.value

  depends_on = [github_repository.repository]
}

resource "github_issue_label" "label" {
  for_each = var.github_issue_label

  repository = github_repository.repository.id

  name        = each.value.name
  color       = each.value.color
  description = each.value.description
}
