terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

#trivy:ignore:AVD-GIT-0001 No sensitive information
resource "github_repository" "repository" {
  name        = var.github_repository.name
  description = var.github_repository.description
  topics      = var.github_repository.topics
  is_template = var.github_repository.is_template
  visibility  = var.github_repository.visibility
  auto_init   = var.github_repository.auto_init

  has_discussions = var.github_repository.has_discussions
  has_downloads   = var.github_repository.has_downloads
  has_issues      = var.github_repository.has_issues
  has_projects    = var.github_repository.has_projects
  has_wiki        = var.github_repository.has_wiki
  homepage_url    = var.github_repository.homepage_url
  # private = var.github_repository.visibility == "private" ? true : false # DEPRICATED

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

  license_template                        = var.github_repository.license_template == null ? (var.github_repository.visibility == "private" ? "unlicense" : "mit") : var.github_repository.license_template
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
}

resource "github_branch" "branch" {
  for_each = toset(var.github_branch)

  repository = github_repository.repository.id
  branch     = each.value

  depends_on = [github_repository.repository]
}

resource "github_branch_default" "branch" {
  repository = github_repository.repository.id
  branch     = var.github_branch_default

  depends_on = [github_repository.repository]
}

#trivy:ignore:AVD-GIT-0004 No need to sign commits
resource "github_branch_protection" "branch" {
  for_each = var.github_branch_protection

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

  lifecycle {
    replace_triggered_by = [github_repository.repository.id]
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
