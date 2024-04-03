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
  name        = var.name
  description = var.description
  topics      = var.topics
  is_template = var.is_template
  visibility  = var.visibility
  auto_init   = var.auto_init

  has_discussions = var.has_discussions
  has_downloads   = var.has_downloads
  has_issues      = var.has_issues
  has_projects    = var.has_projects
  has_wiki        = var.has_wiki
  homepage_url    = var.homepage_url
  # private = var.visibility == "private" ? true : false # DEPRICATED

  allow_merge_commit          = var.allow_merge_commit
  allow_squash_merge          = var.allow_squash_merge
  allow_rebase_merge          = var.allow_rebase_merge
  allow_auto_merge            = var.allow_auto_merge
  allow_update_branch         = var.allow_update_branch
  squash_merge_commit_title   = var.squash_merge_commit_title
  squash_merge_commit_message = var.squash_merge_commit_message
  merge_commit_title          = var.merge_commit_title
  merge_commit_message        = var.merge_commit_message
  delete_branch_on_merge      = var.delete_branch_on_merge

  license_template                        = var.license_template == null ? (var.visibility == "private" ? "unlicense" : "mit") : var.license_template
  archive_on_destroy                      = var.archive_on_destroy
  web_commit_signoff_required             = var.web_commit_signoff_required
  vulnerability_alerts                    = var.vulnerability_alerts
  ignore_vulnerability_alerts_during_read = var.ignore_vulnerability_alerts_during_read # true

  dynamic "template" {
    for_each = var.template != null ? [1] : []

    content {
      owner                = var.template.owner
      repository           = var.template.repository
      include_all_branches = var.template.include_all_branches
    }
  }

  dynamic "pages" {
    for_each = var.pages != null ? [1] : []

    content {
      build_type = var.pages.build_type
      cname      = var.pages.cname


      dynamic "source" {
        for_each = var.pages.source != null ? [1] : []

        content {
          branch = var.pages.source.branch
          path   = var.pages.source.path
        }
      }
    }
  }

  security_and_analysis {
    dynamic "advanced_security" {
      for_each = var.visibility == "public" ? [1] : []

      content {
        status = var.security_and_analysis.advanced_security.status
      }
    }

    dynamic "secret_scanning" {
      for_each = var.visibility == "public" ? [1] : []

      content {
        status = var.security_and_analysis.secret_scanning.status
      }
    }

    dynamic "secret_scanning_push_protection" {
      for_each = var.visibility == "public" ? [1] : []

      content {
        status = var.security_and_analysis.secret_scanning_push_protection.status
      }
    }
  }
}

# output "security_and_analysis" {
#   value = null

#   precondition {
#     condition = (
#       (var.visibility == "private" && (
#         var.security_and_analysis.secret_scanning_push_protection.status == "disabled" ||
#         var.security_and_analysis.secret_scanning.status == "disabled" ||
#         var.security_and_analysis.advanced_security.status == "disabled"
#       )) || (var.visibility == "public" && (
#         var.security_and_analysis.secret_scanning_push_protection.status == "enabled" &&
#         var.security_and_analysis.secret_scanning.status == "enabled" &&
#         var.security_and_analysis.advanced_security.status == "enabled"
#       ))
#     )
#     error_message = "Must be enabled for public repository."
#   }
# }
