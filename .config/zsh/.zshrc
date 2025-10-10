# >>> oh my zsh >>
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/dotfiles/.config/zsh/oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# zsh-syntax-highlighting の下線（underline）を無効化
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES

# ファイルパスまわりの下線を消す
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

# unknown-token（入力途中のコマンド名など）の下線を消す
ZSH_HIGHLIGHT_STYLES[unknown-token]=none

# sudo などの precommand 部分の下線を消す
ZSH_HIGHLIGHT_STYLES[precommand]=none
# <<< oh my zsh <<<

# >>> git >>>
export PATH=/opt/homebrew/bin/git:$PATH
# <<< git <<<

# >>> nodebrew >>>
export PATH=$HOME/.nodebrew/current/bin:$PATH
# <<< nodebrew <<<

# >>> ojt >>>
alias ojt='oj t -c "python main.py" -d test'
# <<< ojt <<<

# >>> acc >>>
alias ass="acc s main.py -- --guess-python-interpreter pypy"
# <<< acc <<<

# >>> rbenv >>>
eval "$(rbenv init - zsh)"
# <<< rbenv <<<

# >>> pyenv >>>
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
# <<< pyenv <<<

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/okudayota/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/okudayota/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/okudayota/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/okudayota/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# >>> venvs >>>
alias atcoder='source ~/venvs/atcoder/bin/activate'
# <<< venvs <<<
eval "$(rbenv init -)"
