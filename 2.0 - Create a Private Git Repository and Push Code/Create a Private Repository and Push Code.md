# Steps to Create a Private Git Repository and Push Code

## Create a Private Git Repository

1. Visit your preferred Git hosting platform (e.g., GitHub, GitLab, Bitbucket).
2. Log in to your account or register if you're new.
3. Create a new repository and set its visibility to private.

## Generate a Personal Access Token

1. Go to your account settings or profile settings.
2. Find the Developer settings or Personal access tokens section.
3. Generate a new token, ensuring it has the necessary permissions, such as repository access.

## Clone the Repository Locally

1. Open Git Bash or your terminal.
2. Navigate to the directory where you want to clone the repository.
3. Execute the `git clone` command followed by the repository's URL.

## Add Your Source Code Files

1. Navigate into the cloned repository directory.
2. Paste your source code files or create new ones in this directory.

## Stage and Commit Changes

1. Use the `git add` command to stage the changes.
2. Utilize the `git commit` command to commit the staged changes with a descriptive message.

## Push Changes to the Repository

1. Execute the `git push` command to push your committed changes to the remote repository.
2. If it's your first time pushing to this repository, specify the remote and branch.

## Enter Personal Access Token for Authentication

1. During the push, when prompted for credentials, input your username (usually your email).
2. Use your personal access token as the password for authentication.

By following these instructions, you'll create a private Git repository, connect to it, and securely push your code changes using a personal access token.
