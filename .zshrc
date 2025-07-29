
# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"


# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME=""


# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder


# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-autosuggestions fzf)
source $ZSH/oh-my-zsh.sh


# Oh my Zsh Theme Config
precmd() {
  print -Pn "\n%F{yellow}[%m]%f %F{cyan}%d%f\n"
}

PROMPT="%(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} ) %{$fg[cyan]%}%{$reset_color%}"
PROMPT+=' $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}%1{✗%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"


if [ -f /.dockerenv ]; then
  neofetch --ascii_distro CRUX_small --disable gpu shell resolution wm theme icons cols term memory de
  alias ls='exa -lh --git --tree -L 1 --icons --group-directories-first'
  alias lsa='exa -lah --git --tree -L 1 --icons --group-directories-first'
  alias fd='fdfind'
elif [[ "$(uname -a)" = *"Darwin"* ]]; then
  neofetch --ascii_distro Mac_small --disable gpu shell resolution wm theme icons cols term memory de
  alias ls='eza -lh --git --tree -L 1 --icons --group-directories-first'
  alias lsa='eza -lah --git --tree -L 1 --icons --group-directories-first'
else
  if [ ! "$TERM_PROGRAM" = tmux ]; then tmux; fi
  neofetch --ascii_distro Ubuntu_small --disable gpu shell resolution wm theme icons cols term memory de
  # homebrew path
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  alias ls='exa -lh --git --tree -L 1 --icons --group-directories-first'
  alias lsa='exa -lah --git --tree -L 1 --icons --group-directories-first'
  alias fd='fdfind'
fi


# Histfile Configuration
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=10000

alias dfgit='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'


