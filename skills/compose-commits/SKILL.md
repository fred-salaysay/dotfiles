# compose-commits

Inspect the files changed and understand what the changes are for. More importantly, understand which changes are related to each other.

Your task is to stage related changes so that they can be committed together. The idea is so that when a PR is created from these commits, reviewers should be able to read the commits and be able to visualize the developer journey that allowed the feature to be implement, or the bug to be resolved.

Things to note:

- ideally, the commits should tell the step-by-step process of what the developer did to implement the feature or resolve the bug so order of commits is important
- inspect the hunks in each individual file to see if they are related to each other; it's possible for multiple hunks in a single file to not be related to each other
- commit the staged changes and stick to the conventional commit format: `type(scope?): subject  #scope is optional; multiple scopes are supported (current delimiter options: "/", "\" and ",")`
- commit message should fit in oneline with an extended description at the bottom
- **do not push** the commits to remote; let the user do it
- ensure the commits are commitlint compatible
