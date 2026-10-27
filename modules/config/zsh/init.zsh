# --- completion: fish-style menu ---

# arrow keys move through the list, typed lowercase matches any case,
# and a word can match in the middle (`conf` finds `nixos-config`)
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%F{yellow}%d%f'

# --- keys ---

# ctrl+w / alt+backspace stop at `/`, like fish
WORDCHARS=${WORDCHARS//\/}

bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[OH' beginning-of-line
bindkey '^[OF' end-of-line
bindkey '^[[3~' delete-char
bindkey '^[[Z' reverse-menu-complete

# alt/ctrl + arrows jump words; alt+right also takes one word of a suggestion
bindkey '^[[1;3C' forward-word
bindkey '^[[1;3D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# alt+e / alt+v open the command line in $EDITOR
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^[e' edit-command-line
bindkey '^[v' edit-command-line

# alt+s toggles sudo in front of the command (or the last one, if the line is empty)
toggle-sudo() {
  if [[ -z $BUFFER ]]; then
    BUFFER=$(fc -ln -1)
  fi

  if [[ $BUFFER == sudo\ * ]]; then
    BUFFER=${BUFFER#sudo }
  else
    BUFFER="sudo $BUFFER"
  fi

  CURSOR=${#BUFFER}
}
zle -N toggle-sudo
bindkey '^[s' toggle-sudo

# --- prompt: same look as the old fish_prompt ---

# fish's prompt_pwd: every directory but the last cut to one letter (~/P/amane)
prompt_pwd() {
  local dir=${PWD/#$HOME/\~}
  local -a parts=("${(@s:/:)dir}")
  local short=""

  local i
  for (( i = 1; i < $#parts; i++ )); do
    local part=$parts[i]

    # hidden dirs keep the dot, so ~/.config becomes ~/.c
    if [[ $part == .* ]]; then
      short+=${part[1,2]}/
    else
      short+=${part[1]}/
    fi
  done

  print -rn -- "$short$parts[-1]"
}

prompt_git() {
  command git rev-parse --is-inside-work-tree &>/dev/null || return

  local branch=$(command git branch --show-current 2>/dev/null)
  if [[ -z $branch ]]; then
    branch=$(command git rev-parse --short HEAD 2>/dev/null)
  fi
  [[ -z $branch ]] && return

  local dirty=""
  if ! command git diff --no-ext-diff --quiet --ignore-submodules 2>/dev/null \
    || ! command git diff --cached --no-ext-diff --quiet --ignore-submodules 2>/dev/null; then
    dirty="%F{red}*%f"
  fi

  # `%` in a branch name would be read as a prompt escape
  print -rn -- "%F{8}(%F{yellow}${branch//\%/%%}%F{8})%f$dirty"
}

update_prompt() {
  local cwd=$(prompt_pwd)
  local top="%F{8}╭─ [%B%F{white}${cwd//\%/%%}%F{8}]%b%f$(prompt_git)"
  local bottom="%F{8}╰─ %(?.%B.%F{red})λ%b%f "

  PROMPT="$top"$'\n'"$bottom"
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd update_prompt
