goto() {
  msg_bad_use="Bad command usage"
  msg_help="Use \"goto -h\" for commands and usage"
  msg_usage="Usage:\n  To go to OBJ: \t\t\tgoto [OBJ]\n  To see the directories: \tgoto -d\n   To get OBJ's path: \t\tgoto -d [OBJ]\n  To add a new directory: \tgoto -a [OBJ] [/absolute/path/to/objective]\n  To open the file browser: \tgoto -o [OBJ]\n  To remove a directory:\t\tgoto -r [OBJ]"

  dir_file=$HOME/gotoDIRS

  if [ $# = 0 ]; then
          echo $msg_help
  else
    case $1 in
      -h) echo -e $msg_usage
          ;;
      -a) if [ $# = 3 ]; then
            line="$2: $3"
            echo $line >>$dir_file
            echo -e "Added \n $line \n to the directories"
          elif [ $# = 2 ]; then
            line="$2: $PWD"
            echo $line >>$dir_file
            echo -e "Added \n $line \n to the directories"
          else
                  echo $msg_bad_use
                  echo $msg_help
          fi
          ;;
      -d) if [ $# = 2 ]; then
            results=$(cut -d ' ' -f 1 $dir_file | grep -e "^$2:" -c)
            if [ $results = 0 ]; then
              echo "Keyword $2 not found."
              matches=$(grep -e "^.*$2.*: " $dir_file)
              if [ $(grep -e "^.*$2.*: " $dir_file -c) = 0 ]; then
                echo "No matches found. To add a new entry use: \n \t goto -add [keyword] [path]"
              else
                echo "Keyword $2 matches with: "
                echo $matches | sed 's/\/ /\n/g'
              fi
            else
              dir=$(grep -e "^$2:" $dir_file | cut -d ' ' -f 2)
              echo $dir
            fi
        else
          cat $dir_file
        fi
        ;;
    -o) if [ $# = 1 ];then
          gnome-open . &>/dev/null
        else
          results=$(cut -d ' ' -f 1 $dir_file | grep -e $2 -c)
          if [ $results = 0 ]; then
            echo -e "$2 is not a keyword for any directory. To add a new entry use: \n \t goto -add [keyword] [path]"
          else
            dir=$(grep -e "^$2:" $dir_file | cut -d ' ' -f 2)
            gnome-open $dir &>/dev/null
          fi
        fi
        ;;
    -r) results=$(cut -d ' ' -f 1 $dir_file | grep -e "^$2:" -c)
        if [ $results = 0 ]; then
          echo -e "$2 is not a keyword for any directory."
        else
          sed "/^$2: /d" -i $dir_file
          echo "Keyword $2 removed"
        fi
        ;;
    *) results=$(cut -d ' ' -f 1 $dir_file | grep -e "^$1:" -c)
        if [ $results = 0 ]; then
          echo "Keyword $1 not found."
          matches=$(grep -e "^.*$1.*: " $dir_file)
          if [ $(grep -e "^.*$1.*: " $dir_file -c) = 0 ]; then
            echo -e "No matches found. To add a new entry use: \n \t goto -add [keyword] [path]"
          else
            echo "Keyword $1 matches with: "
            echo $matches | sed 's/\/ /\n/g'
          fi
      else
      	dir=$(grep -e "^$1:" $dir_file | cut -d ' ' -f 2)
        cd $dir
      fi
      ;;
    esac
  fi
}

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
      git config user.email "gallardo91_@hotmail.com";
      git config user.name "maktub82";
      ;;
    vsts)
      git config user.email "gallardo91_@hotmail.com";
      git config user.name "Sergio Gallardo Sales";
      ;;
  esac
}
