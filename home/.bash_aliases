alias s='sudo'
alias ack="~/bin/ack"

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# git aliases
alias g=git
alias gti=git
alias gpast='for k in `git branch -r|sed s/^..//`;do echo -e `git log -1 --date=short --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" "$k" --`\\t"$k";done|sort'

# vim aliases
alias v='vim'
alias vs='sudo vim'
alias eh='sudo vim /etc/hosts'

# apt aliases
alias sagi='sudo apt-get install'

# When using sudo, use alias expansion (otherwise sudo ignores your aliases)
alias sudo='sudo '
