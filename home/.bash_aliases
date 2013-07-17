# version bump alias from peterb for deployments
alias versionbump='dch --distribution unstable --upstream --increment'
alias s='sudo'
alias cddd='cd ~/dev/deploy'
alias ver="grep '\$release\|^\$TOTARA->version\|->version' version.php"

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# git aliases
alias g='git-achievements'
alias git='git-achievements'
alias gti='git-achievements'
alias gpast='for k in `git branch -r|sed s/^..//`;do echo -e `git log -1 --date=short --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" "$k" --`\\t"$k";done|sort'

# vim aliases
alias v='vim'
alias vs='sudo vim'
alias eh='sudo vim /etc/hosts'

# apt aliases
alias sagi='sudo apt-get install'

