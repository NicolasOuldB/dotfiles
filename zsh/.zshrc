# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ---------------------
# Detect OS
# ---------------------
OS="$(uname -s)"

# ---------------------
# Path and Environment
# ---------------------
export NVM_DIR="$HOME/.nvm"
if [[ -s "/opt/homebrew/opt/nvm/nvm.sh" ]]; then
  source "/opt/homebrew/opt/nvm/nvm.sh"
elif [[ -s "$NVM_DIR/nvm.sh" ]]; then
  source "$NVM_DIR/nvm.sh"
fi

export VISUAL=nvim
export EDITOR=nvim

# NVM setup (adjust path based on platform)
export NVM_DIR="$HOME/.nvm"
if [[ "$OS" == "Darwin" ]]; then
  # macOS: use Homebrew path if available
  [[ -s "/opt/homebrew/opt/nvm/nvm.sh" ]] && source "/opt/homebrew/opt/nvm/nvm.sh"
else
  # Linux default
  [[ -s "/usr/share/nvm/init-nvm.sh" ]] && source "/usr/share/nvm/init-nvm.sh"
fi

# ---------------------
# Keybings
# ---------------------
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# ---------------------
# History settings
# ---------------------
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
HISTDUP=erase

setopt NO_BEEP
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS
setopt SHARE_HISTORY
setopt APPEND_HISTORY

# ---------------------
# zinit (Plugin manager)
# ---------------------
if [[ ! -f ~/.zinit/bin/zinit.zsh ]]; then
  mkdir -p ~/.zinit && \
  git clone https://github.com/zdharma-continuum/zinit.git ~/.zinit/bin
fi

source ~/.zinit/bin/zinit.zsh

# ---------------------
# Zinit plugins 
# ---------------------
# Powerlevel10k settings
zinit ice depth=1; zinit light romkatv/powerlevel10k
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Completion
zinit light zsh-users/zsh-completions

# Autosuggestions
zinit light zsh-users/zsh-autosuggestions

# FZF and related
zinit light Aloxaf/fzf-tab

# Highlighting (should be last plugin)
zinit light zsh-users/zsh-syntax-highlighting

# ---------------------
# Zinit snippets
# ---------------------
# Command not found
zinit snippet OMZP::command-not-found

# ---------------------
# Customization
# ---------------------
# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

# FZF styling
if command -v gls &>/dev/null; then
  zstyle ':fzf-tab:complete:cd:*' fzf-preview 'gls -a --color=always -F $realpath 2>/dev/null'
else
  zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -a -G -F $realpath 2>/dev/null'
fi

autoload -Uz compinit && compinit # should stay after zinits and zstyles

# Aliases
if [[ "$OS" == "Darwin" ]]; then
  # macOS: use `gls` if coreutils is installed
  if command -v gls &> /dev/null; then
    alias ls='gls --color=auto -F'
  else
    alias ls='ls -G -F'
  fi
else
  alias ls='ls --color=auto -F'
fi

# Load local overrides (not tracked by stow/dotfiles)
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

