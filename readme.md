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
| <a name="provider_github"></a> [github](#provider\_github) | 6.2.0 |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 6.0 |

## Resources

| Name | Type |
|------|------|
| [github_repository.repository](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_auto_merge"></a> [allow\_auto\_merge](#input\_allow\_auto\_merge) | Whether to allow auto-merges. | `bool` | `false` | no |
| <a name="input_allow_merge_commit"></a> [allow\_merge\_commit](#input\_allow\_merge\_commit) | Whether to allow merge commits. | `bool` | `true` | no |
| <a name="input_allow_rebase_merge"></a> [allow\_rebase\_merge](#input\_allow\_rebase\_merge) | Whether to allow rebase merges. | `bool` | `true` | no |
| <a name="input_allow_squash_merge"></a> [allow\_squash\_merge](#input\_allow\_squash\_merge) | Whether to allow squash merges. | `bool` | `true` | no |
| <a name="input_allow_update_branch"></a> [allow\_update\_branch](#input\_allow\_update\_branch) | Whether to allow update branches. | `bool` | `true` | no |
| <a name="input_archive_on_destroy"></a> [archive\_on\_destroy](#input\_archive\_on\_destroy) | Whether to archive the repository on destroy. | `bool` | `true` | no |
| <a name="input_auto_init"></a> [auto\_init](#input\_auto\_init) | Automatically create the default branch. | `bool` | `true` | no |
| <a name="input_delete_branch_on_merge"></a> [delete\_branch\_on\_merge](#input\_delete\_branch\_on\_merge) | Whether to delete the branch on merge. | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | A description of the repository | `string` | `null` | no |
| <a name="input_has_discussions"></a> [has\_discussions](#input\_has\_discussions) | Whether the repository has discussions. | `bool` | `false` | no |
| <a name="input_has_downloads"></a> [has\_downloads](#input\_has\_downloads) | Whether the repository has downloads. | `bool` | `false` | no |
| <a name="input_has_issues"></a> [has\_issues](#input\_has\_issues) | Whether the repository has issues. | `bool` | `false` | no |
| <a name="input_has_projects"></a> [has\_projects](#input\_has\_projects) | Whether the repository has projects. | `bool` | `false` | no |
| <a name="input_has_wiki"></a> [has\_wiki](#input\_has\_wiki) | Whether the repository has wiki. | `bool` | `false` | no |
| <a name="input_homepage_url"></a> [homepage\_url](#input\_homepage\_url) | The URL of the repository's homepage. | `string` | `null` | no |
| <a name="input_ignore_vulnerability_alerts_during_read"></a> [ignore\_vulnerability\_alerts\_during\_read](#input\_ignore\_vulnerability\_alerts\_during\_read) | Whether to ignore vulnerability alerts during read. | `bool` | `true` | no |
| <a name="input_is_template"></a> [is\_template](#input\_is\_template) | Whether the repository is a template. | `bool` | `false` | no |
| <a name="input_license_template"></a> [license\_template](#input\_license\_template) | The license template of the repository. | `string` | `null` | no |
| <a name="input_merge_commit_message"></a> [merge\_commit\_message](#input\_merge\_commit\_message) | The message of the merge commit. | `string` | `"PR_BODY"` | no |
| <a name="input_merge_commit_title"></a> [merge\_commit\_title](#input\_merge\_commit\_title) | The title of the merge commit. | `string` | `"PR_TITLE"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the repository. | `string` | n/a | yes |
| <a name="input_pages"></a> [pages](#input\_pages) | Pages repository settings object `github_repository`. | <pre>object({<br>    source = object({<br>      branch = string<br>      path   = string<br>    })<br><br>    build_type = string<br>    cname      = string<br>  })</pre> | `null` | no |
| <a name="input_security_and_analysis"></a> [security\_and\_analysis](#input\_security\_and\_analysis) | Security and analysis repository settings object `github_repository`. | <pre>object({<br>    advanced_security = object({<br>      status = string<br>    })<br>    secret_scanning = object({<br>      status = string<br>    })<br>    secret_scanning_push_protection = object({<br>      status = string<br>    })<br>  })</pre> | <pre>{<br>  "advanced_security": {<br>    "status": "enabled"<br>  },<br>  "secret_scanning": {<br>    "status": "enabled"<br>  },<br>  "secret_scanning_push_protection": {<br>    "status": "enabled"<br>  }<br>}</pre> | no |
| <a name="input_squash_merge_commit_message"></a> [squash\_merge\_commit\_message](#input\_squash\_merge\_commit\_message) | The message of the merge commit. | `string` | `"PR_BODY"` | no |
| <a name="input_squash_merge_commit_title"></a> [squash\_merge\_commit\_title](#input\_squash\_merge\_commit\_title) | The title of the merge commit. | `string` | `"PR_TITLE"` | no |
| <a name="input_template"></a> [template](#input\_template) | Template repository settings object `github_repository`. | <pre>object({<br>    owner                = string<br>    repository           = any<br>    include_all_branches = bool<br>  })</pre> | `null` | no |
| <a name="input_topics"></a> [topics](#input\_topics) | The list of topics of the repository. | `list(string)` | `[]` | no |
| <a name="input_visibility"></a> [visibility](#input\_visibility) | The visibility of the repository. | `string` | `"private"` | no |
| <a name="input_vulnerability_alerts"></a> [vulnerability\_alerts](#input\_vulnerability\_alerts) | Whether to enable vulnerability alerts. | `string` | `true` | no |
| <a name="input_web_commit_signoff_required"></a> [web\_commit\_signoff\_required](#input\_web\_commit\_signoff\_required) | Whether to require signed commits. | `bool` | `false` | no |

## Modules

No modules.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_out"></a> [out](#output\_out) | Repository settings object `github_repository`. |
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->

## Contributions

This module is created by Inetum Poland. Feel free to contribute to it.
