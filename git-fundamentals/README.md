# Git Fundamentals
## What is Git?
Git is a distributed version control system (VCS) for tracking changes made to computer files and coordinating work on these with with multiple people.
It helps you keep track of changes made to your code similar to browser history tab. Allowing you revert to a stable state if you encounter fatal errors while coding.
In addition to allowing to view the changes you made to code over time
![[git-change-examples.png|600x244]]
## Git Workflow
consist of the following: **Working Directory**, **Staging Area**, **Local Repository** and **Remote Repository**.
![[git-workflow.png|509x299]]

A file in a working directory can be in three possible state
- **It can be staged** - Which means the files with the updated changes are marked to be committed to the local repository but not yet committed. Done with `git add` , which is a command used to add a file that is in the working directory to the staging area.
- **It can be modified** - Which means the files with the updated changes are not yet stored in the local repository. State after `git add` and before `git commit`. a command used to add a file that is in the working directory to the staging area.
- **It can be committed** - Which means that the changes you made to your file are safely stored in the local repository. Ready to be pushed to Remote Repo (MASTER) via`git push`, a command used to add all committed files in the local repository to the remote repository. So in the remote repository, all files and changes will be visible to anyone with access to the remote repository.
**Additional Commands**:
- `git fetch` command is used to get files from the remote repository to the local repository but not into the working directory.
- `git merge` command is used to get the files from the local repository into the working directory.
- `git pull` command is used to get files from the remote repository directly into the working directory. It is equivalent to a `git fetch` and a `git merge` .
- `git remote` command lets you create, view, and delete connections to other repositories.
- `git diff` command shows file changes that aren't staged

## Github
Github is the default cloud-based hosting service for storing git repositories and code online. in addition to facilitating easier collaborating with others and sharing coding publicly or privately.
There are other alternatives such as gitlab, gitea and forgejo which can be self hosted but Github is typically the enterprise default solution.
### Authentication
It is recommended to attach your username and email address to git so each commit has you as the author:
```bash
$ git config --global user.name "YOUR_USERNAME"

$ git config --global user.email "im_satoshi@musk.com"

$ git config --global --list # To check the info you just provided
```

Authentication can also be setup to your github account using ssh key as advised [here](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/). So credentials do have to be entered on each visit.

## Git Projects

```bash
mkdir my-project #Create project directory
cd my-project
#### Initialize Git ####
touch README.md # To create a README file for the repository
git init # Initiates an empty git repository
#### Add files to the Staging Area for commit ####
git add . # Adds all the files in the local repository and stages them for commit
git status # Lists all new or modified files to be committed
#### Commit Changes you made to your Git Repo ####
git commit -m "First commit" #insert commit notes within ""
#### Uncommit Changes you just made to your Git Repo ###
git reset HEAD~1 #Remove most recent commit
#### Add a remote origin and Push ###
git remote add origin remote_repository_URL #sets the new remote
git remote -v # List the remote connections you have to other repositories.
git push -u origin master # pushes changes to origin
```
## Commit Best Practise
Best Practises with committing make it easier to work in teams and interpret changes 
### Branch
A parallel version of master for working of features
Committing to the `master`  branch directly is against best practise as the master branch represents working stable code.
New Features should be pushed to a new branch before being merged with master

### Commit Structuring:
Basic Structure:
```txt
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```
- Type and colon are required: `feat:` not `feat`
- Use lowercase for types (be consistent)
- Keep description concise and imperative mood
- Separate body/footer with blank lines
- Workflow - One commit = one logical change
#### Core Types (type)
**feat:** New feature (triggers MINOR version bump)
```
feat: add user authentication
feat(auth): implement OAuth2 login
```
**fix:** Bug fix (triggers PATCH version bump)
```txt
fix: resolve null pointer exception in payment flow
fix(api): correct response format for user endpoint
```
**BREAKING CHANGE:** Breaking API change (triggers MAJOR version bump)
```txt
feat!: remove deprecated getUserInfo method

BREAKING CHANGE: getUserInfo() replaced with getUser()
```
**Common Additional Types:**
```txt
docs: update API documentation
style: format code with prettier
refactor: restructure database queries
perf: improve image loading speed
test: add unit tests for auth module
build: upgrade webpack to v5
ci: add GitHub Actions workflow
chore: update dependencies
```
**Basic Structure with context:**
```txt
fix: prevent racing of requests

Introduce request ID and reference to latest request. Dismiss
incoming responses other than from latest request.

Reviewed-by: Kasonde A. Sefuke
Refs: #123

## Sources
- [Conventional Commit](https://www.conventionalcommits.org/en/v1.0.0/)
- [Kubecraft - Git Fundamentals](https://www.skool.com/kubecraft/classroom/1c6ab39e?md=e68811f0d8734c719d76db7062fd6e64)
- [Freecodecamp - Git Basics](https://www.freecodecamp.org/news/learn-the-basics-of-git-in-under-10-minutes-da548267cc91/)
