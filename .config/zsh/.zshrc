# >>> git >>>
export PATH=/opt/homebrew/bin/git:$PATH
# <<< git <<<

# >>> nodebrew >>>
export PATH=$HOME/.nodebrew/current/bin:$PATH
# <<< nodebrew <<<

# >>> ojt >>>
alias ojt='oj t -c "go run main.go" -d tests'
# <<< ojt <<<

# >>> acc >>>
alias accs="acc s -- main.go --language 6051"
# <<< acc <<<

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/okudayota/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/okudayota/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/okudayota/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/okudayota/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# >>> venvs >>>
alias atcoder='source ~/venvs/atcoder/bin/activate'
# <<< venvs <<<

# completion
autoload -Uz compinit && compinit

# fzf
source <(fzf --zsh)


# ghq
function ghq-fzf() {
  local src=$(ghq list | fzf --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*")
  if [ -n "$src" ]; then
    BUFFER="cd $(ghq root)/$src"
    zle accept-line
  fi
  zle -R -c
}
zle -N ghq-fzf
bindkey '^g' ghq-fzf


# lazygit
alias lg="lazygit"

# >>> starship >>>
# p10kを使う場合は上のoh-my-zshブロックをそのままにして、
# starshipに切り替えたい場合はoh-my-zshブロックをコメントアウトしてこちらを有効化
eval "$(starship init zsh)"
# <<< starship <<<
eval "$(mise activate zsh)"

# pnpm
export PNPM_HOME="/Users/yotaokuda/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end
