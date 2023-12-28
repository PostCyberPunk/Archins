read -p "User:" uname
read -p "email:" umail

git config --global user.name $uname
git config --global user.mail $umail
git config --global init.defaultBranch main
git config --global credential.credentialStore cache
git config --global credential.cacheOptions "--timeout 3600"
git config --global credential.helper git-credential-manager
