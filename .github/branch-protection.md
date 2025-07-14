# Branch Protection Setup

To enable branch protection for this repository, please follow these steps on GitHub:

## Main Branch Protection

1. Go to Settings → Branches
2. Add rule for `main` branch:
   - ✅ Require a pull request before merging
   - ✅ Require approvals (1)
   - ✅ Dismiss stale pull request approvals
   - ✅ Require status checks to pass
   - ✅ Require branches to be up to date
   - ✅ Include administrators

## Develop Branch Protection

1. Add rule for `develop` branch:
   - ✅ Require a pull request before merging
   - ✅ Require approvals (1)
   - ✅ Require branches to be up to date

This ensures code quality and review process.