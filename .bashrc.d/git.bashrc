gclean() {
	if [ $# = 0 ]; then
    git fetch;
		git branch -D "develop";
		git checkout "develop";
  else
		git fetch;
		git branch -D $1;
		git checkout $1;
	fi
}

gnewf() {
	git checkout -b "feature/"$1;
}

gnewb() {
	git checkout -b "bug/"$1;
}

gbclean() {
	branches=$(git branch | grep -v \* | xargs);
	git branch -D $branches;
}

gsquash() {
  git fetch;
  if [ $# = 0 ]; then
    git rebase -i origin/develop;
  else
    git rebase -i "origin/"$1;
	fi
}

gundo() {
  git checkout .;
}

gtree() {
  git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative --branches;
}

gcache() {
	git clean -dfx;
}

guser() {
  case $1 in
    plain)
      git config user.email "sgallardo@plainconcepts.com";
      git config user.name "Sergio Gallardo Sales";
      ;;
    github)
      git config user.email "ikeinyyo@outlook.com";
      git config user.name "ikeinyyo";
      ;;
    vsts)
      git config user.email "gallardo91_@hotmail.com";
      git config user.name "Sergio Gallardo Sales";
      ;;
     ikein)
      git config user.email "ikeinyyo@outlook.com";
      git config user.name "Sergio Gallardo Sales";
      ;;
  esac
}

gupdate() {
  git fetch;
  current_branch=$(git symbolic-ref --short -q HEAD);
  git checkout -b tmp
  git branch -D $current_branch;
  git checkout $current_branch
  git branch -D tmp;
}

glock() {
  git update-index --assume-unchanged $1
}