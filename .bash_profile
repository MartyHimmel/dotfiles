# Colors
CYAN='\[\e[0;36m\]'
GREEN='\[\e[0;32m\]'
LIGHTGRAY='\[\e[0;37m\]'
MAGENTA='\[\e[0;35m\]'
RESET_FORMAT='\[\e[0m\]'

# Customize Prompt
GIT_BRANCH="${MAGENTA}\$(git branch 2>/dev/null | grep '^*' | colrm 1 2)${LIGHTGRAY}"
export PS1="\n${CYAN}\u ${GREEN}\W${LIGHTGRAY}:${GIT_BRANCH} => ${RESET_FORMAT}"
export PS2="=> "

source ~/dotfiles/.aliases
source ~/dotfiles/.functions
