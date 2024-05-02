# Checks

check "repo_name_check" {
  assert {
    condition     = length(var.github_repository.name) > 0
    error_message = "Must not be empty."
  }
}

check "repo_name_underscore_check" {
  assert {
    condition     = can(regex("^[0-9A-Za-z-]+$", var.github_repository.name))
    error_message = "Repository name must not contain an underscore (_)."
  }
}

check "repo_visibility_check" {
  assert {
    condition     = contains(["private", "public"], var.github_repository.visibility)
    error_message = "Must be one of 'private', 'public'."
  }
}

check "repo_security_check" {
  assert {
    condition     = contains(["enabled", "disabled"], coalesce(var.github_repository.security_and_analysis, { advanced_security = { status = "enabled" } }).advanced_security.status, )
    error_message = "Must be enabled or disabled"
  }
}

check "repo_secret_scanning_check" {
  assert {
    condition     = contains(["enabled", "disabled"], coalesce(var.github_repository.security_and_analysis, { secret_scanning = { status = "enabled" } }).secret_scanning.status)
    error_message = "Must be enabled or disabled"
  }
}

check "repo_secret_scanning_push_protection_check" {
  assert {
    condition     = contains(["enabled", "disabled"], coalesce(var.github_repository.security_and_analysis, { secret_scanning_push_protection = { status = "enabled" } }).secret_scanning_push_protection.status)
    error_message = "Must be enabled or disabled"
  }
}
