# git-devops-workflow
Elevate labs task 4 

# git-devops-workflow

**Elevate Labs DevOps Internship - Task 4: Build a Version-Controlled DevOps Project with Git**

A small DevOps project (a `.gitignore` and a health-check script) managed with Git best practices: separate branches, pull requests, clear commit messages and a release tag.

## Branch workflow

```
feature/add-healthcheck-script --PR #1--> dev --PR #2--> main  (tag v1.0.0)
```

| Branch | Purpose |
| --- | --- |
| `main` | Stable, release-ready code. Only changes that came through `dev`. |
| `dev` | Integration branch where finished features are combined and checked. |
| `feature/*` | One branch per piece of work (here `feature/add-healthcheck-script`). |
| `docs/*` | Documentation changes (this README). |

## What I did

1. Created the repo on GitHub and opened it in a GitHub Codespace.
2. Created `dev` from `main` and pushed it.
3. Created `feature/add-healthcheck-script` from `dev`.
4. Made two separate commits on the feature branch:
   - `Add .gitignore for common DevOps files`
   - `Add healthcheck script to test website availability`
5. Pushed the feature branch and opened **pull request #1** into `dev`, then merged it.
6. Opened **pull request #2** from `dev` into `main` and merged it.
7. Created the annotated tag **`v1.0.0`** on `main` and pushed it.
8. Wrote this README on a `docs/update-readme` branch and merged it with another pull request.

## Files

- `.gitignore`: keeps dependencies, secrets (`.env`, `*.pem`), logs, Terraform state and editor files out of the repo.
- `healthcheck.sh`: checks whether a URL returns HTTP 200.

```bash
./healthcheck.sh                       # checks my GitHub Pages site
./healthcheck.sh https://example.com   # checks any URL
```

It prints `OK: <url> returned 200` and exits with 0, or prints `FAIL` and exits with 1 (so it can be used in a CI pipeline).

## Git commands used

```bash
git checkout -b dev                          # create and switch to a branch
git push -u origin dev                       # publish the branch
git add <file> && git commit -m "message"    # stage and commit
git push -u origin feature/add-healthcheck-script
git pull                                     # bring merged changes down
git tag -a v1.0.0 -m "Release v1.0.0"        # annotated tag
git push origin v1.0.0                       # publish the tag
git log --oneline --graph                    # view history
```

## Interview questions

**1. What is Git?**
Git is a distributed version control system. It records the history of a project as commits, so I can see what changed, go back to an earlier version, and work on separate branches without affecting the main code. Every developer has a full copy of the history.

**2. What is the difference between merge and rebase?**
Both bring changes from one branch into another. `merge` joins the branches with a merge commit and keeps the real history, including the branching. `rebase` replays my commits on top of the other branch, which gives a straight, linear history but rewrites commits. I should not rebase commits that others already use; I use merge for shared branches like `dev` and `main`.

**3. What is a pull request?**
A pull request (PR) is a request on GitHub to merge one branch into another. It shows the changes, lets others review and comment, can run automated checks, and keeps a record of why a change was made. In this project I used PR #1 (feature into dev) and PR #2 (dev into main).

**4. How do you resolve merge conflicts?**
A conflict happens when two branches change the same lines. Git marks the file with `<<<<<<<`, `=======` and `>>>>>>>`. I open the file, decide which version to keep (or combine them), remove the markers, run `git add <file>`, and finish with `git commit` (or `git rebase --continue` when rebasing). Then I test that everything still works.

**5. What are Git tags?**
A tag is a fixed label on a specific commit, usually used for releases such as `v1.0.0`. Unlike a branch, it does not move. A lightweight tag is just a pointer; an annotated tag (`git tag -a`) also stores the author, date and a message. I used an annotated tag.

**6. What is Git workflow?**
It is the agreed way a team uses branches and merges. A common one is feature branching: work on a `feature/*` branch, merge it into `dev` through a pull request, then release from `dev` to `main`. This keeps `main` stable and makes changes reviewable. That is what I followed here.

**7. Explain git stash.**
`git stash` temporarily saves my uncommitted changes and gives me a clean working directory, so I can switch branches without committing half-finished work. `git stash list` shows saved stashes, `git stash pop` restores the latest one and removes it from the list, and `git stash apply` restores it but keeps it.

**8. What is the use of .gitignore?**
`.gitignore` lists files and folders Git should not track, such as `node_modules/`, `.env` files with secrets, logs, build output, Terraform state files and editor settings. It keeps the repo clean and prevents secrets or large generated files from being committed. Files that are already tracked must be removed from Git first (`git rm --cached`).