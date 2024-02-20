gclean() {
  if [ $# = 0 ]; then
    git fetch
    git branch -D "develop"
    git checkout "develop"
  elif [ $# = 1 ]; then
    git fetch
    git branch -D $1
    git checkout $1
  else
    git fetch $1
    git branch -D $2 || true
    git checkout --track $1/$2
  fi
}

gnewf() {
  git checkout -b "feature/"$1
}

gnewb() {
  git checkout -b "bug/"$1
}

gbclean() {
  branches=$(git branch | grep -v \* | xargs)
  git branch -D $branches
}

gsquash() {
  git fetch
  if [ $# = 0 ]; then
    git rebase -i origin/develop
  elif [ $# = 1 ]; then
    git rebase -i "origin/"$1
  else
    git rebase -i $1/$2
  fi
}

gundo() {
  git checkout .
}

gtree() {
  git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative --branches
}

gcache() {
  git clean -dfx
}

guser() {
  case $1 in
  plain)
    git config user.email "sgallardo@plainconcepts.com"
    git config user.name "Sergio Gallardo Sales"
    ;;
  github)
    git config user.email "ikeinyyo@outlook.com"
    git config user.name "ikeinyyo"
    ;;
  vsts)
    git config user.email "gallardo91_@hotmail.com"
    git config user.name "Sergio Gallardo Sales"
    ;;
  ikein)
    git config user.email "ikeinyyo@outlook.com"
    git config user.name "Sergio Gallardo Sales"
    ;;
  mdw)
    git config user.email "sergio.gallardo@mdwpartners.com"
    git config user.name "Sergio Gallardo"
    ;;
  esac
}

gupdate() {
  git fetch
  current_branch=$(git symbolic-ref --short -q HEAD)
  git checkout -b tmp
  git branch -D $current_branch
  if [ $# = 0 ]; then
    git checkout --track origin/$current_branch
  else
    git checkout --track $1/$current_branch
  fi
  git branch -D tmp
}

glock() {
  git update-index --assume-unchanged $1
}
