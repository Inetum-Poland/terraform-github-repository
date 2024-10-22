# Preconfigured Terraform module for `github_repository`.

[![pre_commit](https://github.com/Inetum-Poland/tf-module-github-repository/actions/workflows/pre_commit.yml/badge.svg)](https://github.com/Inetum-Poland/tf-module-github-repository/actions/workflows/pre_commit.yml) [![trufflehog](https://github.com/Inetum-Poland/tf-module-github-repository/actions/workflows/trufflehog.yaml/badge.svg)](https://github.com/Inetum-Poland/tf-module-github-repository/actions/workflows/trufflehog.yaml)

This module creates a preconfigured GitHub repository.

> [!IMPORTANT]
> __This repository uses the [Conventional Commits](https://www.conventionalcommits.org/).__
>
> For more information please see the [Conventional Commits documentation](https://www.conventionalcommits.org/en/v1.0.0/#summary).

> [!IMPORTANT]
> __This repository uses the [pre-commit](https://pre-commit.com/).__
>
> Please be respectful while contributing and after cloning this repo install the pre-commit hooks.
> ```bash
> > pre-commit install --install-hooks -t pre-commit -t commit-msg
> ```
> For more information please see the [pre-commit documentation](https://pre-commit.com/).

<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | 6.3.1 |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 6.0 |

## Resources

| Name | Type |
|------|------|
| [github_actions_secret.secret](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_secret) | resource |
| [github_actions_variable.variable](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_variable) | resource |
| [github_branch_default.branch](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_default) | resource |
| [github_branch_protection.branch](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_protection) | resource |
| [github_dependabot_secret.secret](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/dependabot_secret) | resource |
| [github_issue_label.label](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/issue_label) | resource |
| [github_repository.repository](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) | resource |
| [github_repository_ruleset.ruleset](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_ruleset) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_github_actions_secret"></a> [github\_actions\_secret](#input\_github\_actions\_secret) | Actions secret repository settings object `github_actions_secret`. | `map(string)` | `{}` | no |
| <a name="input_github_actions_variable"></a> [github\_actions\_variable](#input\_github\_actions\_variable) | Actions variable repository settings object `github_actions_variable`. | `map(string)` | `{}` | no |
| <a name="input_github_branch_default"></a> [github\_branch\_default](#input\_github\_branch\_default) | Default branch repository settings object `github_branch_default`. | `string` | `null` | no |
| <a name="input_github_branch_protection"></a> [github\_branch\_protection](#input\_github\_branch\_protection) | Branch protection repository settings object `github_branch_protection`. | <pre>map(object({<br/>    pattern = string<br/><br/>    allows_deletions                = optional(bool, false)<br/>    allows_force_pushes             = optional(bool, false)<br/>    enforce_admins                  = optional(bool, false)<br/>    force_push_bypassers            = optional(list(string), [])<br/>    lock_branch                     = optional(bool, false)<br/>    require_conversation_resolution = optional(bool, true)<br/>    require_signed_commits          = optional(bool, false)<br/>    required_linear_history         = optional(bool, false)<br/><br/>    required_pull_request_reviews = optional(object({<br/>      dismiss_stale_reviews           = optional(bool, true)<br/>      require_code_owner_reviews      = optional(bool, true)<br/>      require_last_push_approval      = optional(bool, true)<br/>      required_approving_review_count = optional(number, 1)<br/>      restrict_dismissals             = optional(bool, false)<br/>    }), {})<br/><br/>    required_status_checks = optional(object({<br/>      contexts = optional(list(string), [])<br/>      strict   = optional(bool, true)<br/>    }), {})<br/>  }))</pre> | `{}` | no |
| <a name="input_github_dependabot_secret"></a> [github\_dependabot\_secret](#input\_github\_dependabot\_secret) | Dependabot secret repository settings object `github_dependabot_secret`. | `map(string)` | `{}` | no |
| <a name="input_github_issue_label"></a> [github\_issue\_label](#input\_github\_issue\_label) | Issue labels repository settings object `github_issue_label`. | <pre>map(object({<br/>    name        = string<br/>    color       = string<br/>    description = optional(string, null)<br/>  }))</pre> | `{}` | no |
| <a name="input_github_repository"></a> [github\_repository](#input\_github\_repository) | Repository settings object `github_repository`. | <pre>object({<br/>    name        = string<br/>    description = optional(string)<br/>    topics      = optional(list(string), [])<br/>    is_template = optional(bool, false)<br/>    visibility  = optional(string, "private")<br/><br/>    # auto_init   = optional(bool, true)<br/><br/>    has_downloads   = optional(bool, false)<br/>    has_issues      = optional(bool, false)<br/>    has_projects    = optional(bool, false)<br/>    has_wiki        = optional(bool, false)<br/>    has_discussions = optional(bool, false)<br/>    homepage_url    = optional(string)<br/><br/>    allow_merge_commit          = optional(bool, true)<br/>    allow_squash_merge          = optional(bool, true)<br/>    allow_rebase_merge          = optional(bool, true)<br/>    allow_auto_merge            = optional(bool, false)<br/>    allow_update_branch         = optional(bool, true)<br/>    squash_merge_commit_title   = optional(string, null) # "PR_TITLE"<br/>    squash_merge_commit_message = optional(string, null) # "PR_BODY"<br/>    merge_commit_title          = optional(string, null) # "PR_TITLE"<br/>    merge_commit_message        = optional(string, null) # "PR_BODY"<br/>    delete_branch_on_merge      = optional(bool, true)<br/><br/>    # license_template = optional(string)<br/><br/>    archive_on_destroy                      = optional(bool, true)<br/>    web_commit_signoff_required             = optional(bool, false)<br/>    vulnerability_alerts                    = optional(bool, true)<br/>    ignore_vulnerability_alerts_during_read = optional(bool, true)<br/><br/>    template = optional(object({<br/>      owner                = string<br/>      repository           = any<br/>      include_all_branches = optional(bool, false)<br/>    }), null)<br/><br/>    pages = optional(object({<br/>      source = object({<br/>        branch = string<br/>        path   = string<br/>      })<br/>      build_type = string<br/>      cname      = string<br/>    }), null)<br/><br/>    security_and_analysis = optional(object({<br/>      advanced_security = optional(object({<br/>        status = optional(string, "enabled")<br/>      }), {})<br/>      secret_scanning = optional(object({<br/>        status = optional(string, "enabled")<br/>      }), {})<br/>      secret_scanning_push_protection = optional(object({<br/>        status = optional(string, "enabled")<br/>      }), {})<br/>    }), {})<br/>  })</pre> | n/a | yes |
| <a name="input_github_repository_ruleset"></a> [github\_repository\_ruleset](#input\_github\_repository\_ruleset) | Branch protection repository settings object `github_branch_protection`. | <pre>map(object({<br/>    enforcement = string<br/>    # name        = string<br/>    target = string<br/>    # repository  = string<br/><br/>    rules = list(object({<br/>      branch_name_pattern = optional(object({<br/>        operator = string<br/>        pattern  = string<br/>        name     = optional(string, null)<br/>        negate   = optional(bool, false)<br/>      }), null)<br/><br/>      commit_author_email_pattern = optional(object({<br/>        operator = string<br/>        pattern  = string<br/>        name     = optional(string, null)<br/>        negate   = optional(bool, false)<br/>      }), null)<br/><br/>      commit_message_pattern = optional(object({<br/>        operator = string<br/>        pattern  = string<br/>        name     = optional(string, null)<br/>        negate   = optional(bool, false)<br/>      }), null)<br/><br/>      committer_email_pattern = optional(object({<br/>        operator = string<br/>        pattern  = string<br/>        name     = optional(string, null)<br/>        negate   = optional(bool, false)<br/>      }), null)<br/><br/>      creation         = optional(bool, false)<br/>      deletion         = optional(bool, false)<br/>      non_fast_forward = optional(bool, false)<br/><br/>      pull_request = optional(object({<br/>        dismiss_stale_reviews_on_push     = optional(bool, false)<br/>        require_code_owner_reviews        = optional(bool, false)<br/>        require_last_push_approval        = optional(bool, false)<br/>        required_approving_review_count   = optional(number, 0)<br/>        required_review_thread_resolution = optional(bool, false)<br/>      }), null)<br/><br/>      required_deployments = optional(object({<br/>        required_deployment_environments = list(string)<br/>      }), null)<br/><br/>      required_linear_history = optional(bool, false)<br/>      required_signatures     = optional(bool, false)<br/><br/>      required_status_checks = optional(object({<br/>        required_check = list(object({<br/>          context        = string<br/>          integration_id = optional(number, null)<br/>        }))<br/><br/>        strict_required_status_checks_policy = optional(bool, false)<br/>      }), null)<br/><br/>      tag_name_pattern = optional(object({<br/>        operator = string<br/>        pattern  = string<br/>        name     = optional(string, null)<br/>        negate   = optional(bool, false)<br/>      }), null)<br/><br/>      update                        = optional(bool, false)<br/>      update_allows_fetch_and_merge = optional(bool, false)<br/>    }))<br/><br/>    bypass_actors = optional(list(object({<br/>      actor_id    = number<br/>      actor_type  = optional(string, null)<br/>      bypass_mode = optional(string, null)<br/>    })), null)<br/><br/>    conditions = optional(object({<br/>      ref_name = optional(object({<br/>        exclude = optional(list(string), [])<br/>        include = optional(list(string), [])<br/>      }), null)<br/>    }), null)<br/>  }))</pre> | `{}` | no |

## Modules

No modules.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_out"></a> [out](#output\_out) | Repository settings object `github_repository`. |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->

## Contributions

This module is created by Inetum Poland. Feel free to contribute to it.
