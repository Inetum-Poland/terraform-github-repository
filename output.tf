output "out" {
  value = {
    repository        = github_repository.repository
    branch            = github_branch_default.branch
    branch_protection = github_branch_protection.branch
    actions_variable  = github_actions_variable.variable
    actions_secret    = github_actions_secret.secret
    dependabot_secret = github_dependabot_secret.secret
    issue_label       = github_issue_label.label
  }
  description = "Repository settings object `github_repository`."
}
