#############
# VARIABLES #
#############
# THESE SHOULD BE OVERWRITTEN IN .zshrc.local
export LOCAL_GIT_REPO_PATH="NOT_SET"
# THESE ARE GLOBAL
export LOCAL_FIX=".local"
export PYTHON_VERSION="3.12.4"
export GO_VERSION="1.22.5"
export PYTHON_COMMAND="python"
export ZSHRC_FILE_PATH="$HOME/.zshrc"
export ZSHRC_LOCAL_FILE_PATH=$ZSHRC_FILE_PATH$LOCAL_FIX
export ALACRITTY_FILE_PATH="$HOME/.alacritty.yml"
export TMUX_FILE_PATH="$HOME/.tmux.conf"
export STARSHIP_FILE_PATH="$HOME/.starship.toml"
export VIM_FILE_PATH="$HOME/.vimrc"
export SCRIPTS_PATH="$HOME/scripts"
export PYTHON_SCRIPTS_PATH="$SCRIPTS_PATH/python"
export DOWNLOADS_PATH="$HOME/Downloads"
export PYENV_ROOT="$HOME/.pyenv"
export PACKER_NVIM_PATH="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
export DEPS_DIR_PATH="$HOME/deps"
export NOTES_PATH="$HOME/$LOCAL_FIX.notes"

############
# SOURCING #
############

# python
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv global $PYTHON_VERSION)"
eval "$(pyenv rehash)"
# used as a constant in nvim
export PYTHON_PATH=$(pyenv which python)
# configure pyright
export PYRIGHT_PYTHON_FORCE_VERSION='latest'

# golang
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
eval "$(goenv global $GO_VERSION)"
eval "$(goenv rehash)"

# cargo
# set up cargo
export PATH="$HOME/.cargo/bin:$PATH"

# set up syntax highlighting
source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# set up starship
# https://starship.rs/
export STARSHIP_CONFIG=$STARSHIP_FILE_PATH
eval "$(starship init zsh)"

# Case-insensitive (all), completion (comp) and listing (list).
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Case-insensitive for command execution.
setopt NO_CASE_GLOB
setopt EXTENDED_GLOB

# enable tab completion
autoload -U compinit promptinit

###########
# ALIASES #
###########

# DOTFILES
alias zzl="vim $ZSHRC_FILE_PATH$LOCAL_FIX"
alias applyz="source $ZSHRC_FILE_PATH"
alias applyt="tmux source-file $TMUX_FILE_PATH"

# TMUX
# attach to a session by name
alias tma="tmux attach -t"
# attach to the last session
alias tmaa="tmux attach"
# detach from the current session
alias tmd="tmux detach"
# kill a session by name
alias tmk="tmux kill-session -t"
# kill all sessions except the current
alias tmkk="tmux kill-session -a"
# list all tmux sessions
alias tml="tmux list-sessions"
# create a new named tmux session
alias tmn="tmux new-session -A -s"
# resize current pane
alias rr="tmux resize-pane -R"
alias ll="tmux resize-pane -L"
alias uu="tmux resize-pane -U"
alias dd="tmux resize-pane -D"

# GENERAL QOL
# install any dependencies
alias deps="install_deps"
alias vi="vim"
alias docker-compose="docker compose"
alias dps="docker ps --format '{{.ID}} {{.Image}} {{.Status}}'"
alias ic="ping 8.8.8.8"
alias home='cd ~'
alias ls='eza'
# create a new note
alias note="$PYTHON_COMMAND $PYTHON_SCRIPTS_PATH/notes.py"
# open up notes in nvim
alias nn="cd $NOTES_PATH && nvim"
# screenshot and save to downloads folder
alias ss="screencapture -x $DOWNLOADS_PATH/terminal-screenshot-$(date '+%Y%m%d%H%M%S').png"
alias cls='clear'
alias speed='clearall && speedtest-cli --secure --no-upload'
alias foo='echo "foo\nbar\nbaz\nqux\nquux\ncorge\ngrault\ngarply\nwaldo\nfred\nplugh\nxyxxy\nthud"'
alias make='gmake'
# get shortened URL for given url (surl https://my/url) or for whatever url is copied to clipboard.
# copies shortened URL to clipboard automatically
# s(hort)url
alias surl="$PYTHON_COMMAND $PYTHON_SCRIPTS_PATH/surl.py "
# vimc(heat)s(heet)
alias vimcs='open "https://cheatography.com/marconlsantos/cheat-sheets/neovim/"'
# PYTHON
alias py="$PYTHON_COMMAND"
# open up a project in pypi
# o(pen)pypi
alias opypi="f_opypi"
# check name availability on pypi
# a(vailability)pypi
alias apypi=$PYTHON_COMMAND "$PYTHON_SCRIPTS_PATH/pypi_check.py"
# use venv
alias venv=$PYTHON_COMMAND "-m venv"
alias venvup='f_venvup'
alias venvdown='f_venvdown'
# GIT
alias gitco='git checkout'
alias gitf='git fetch --all'
alias emptycommit='git commit --allow-empty --no-verify -m '\''empty commit'\'' && git push'
alias gcnv="git commit --no-verify"
# list the n most recent git branches
alias recentbranch="git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname:short)' | head -n "
# push to branch that only exists locally and set upstream
alias gpu='git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)'

#############
# FUNCTIONS #
#############

function clearall() {
	# clear the terminal
	clear

	# clear tmux history if in tmux session
	if [ -n "$TMUX" ]; then
		tmux clear-history
	fi
}

function port() {
	lsof -i :"$1"
}

function f_venvup() {
	$PYTHON_COMMAND -m venv "$1"
	source "$1/bin/activate"
}

function f_venvdown() {
	if [ -z "$1" ]; then
		echo "Error: No virtual environment directory specified"
		return 1
	fi

	if [ ! -d "$1" ]; then
		echo "Error: Directory $1 does not exist"
		return 1
	fi

	if source "$1/bin/activate"; then
		deactivate
		rm -rf "$1"
	else
		echo "Failed to activate the virtual environment"
		return 1
	fi
}

# open up the given repo
function c() {
	cd $LOCAL_GIT_REPO_PATH || return
	if [[ -n $1 ]]; then
		cd "$1" || return
	fi
}

# download a youtube link to mp3
function mp3() {
	unsetopt glob
	$PYTHON_COMMAND "$PYTHON_SCRIPTS_PATH/mp_download.py" "mp3" "$1"
	setopt glob
}

# download a youtube link to mp4
function mp4() {
	unsetopt glob
	$PYTHON_COMMAND "$PYTHON_SCRIPTS_PATH/mp_download.py" "mp4" "$1"
	setopt glob
}

function install_deps() {
	# create symlinks if needed
	# THIS SHOULD BE FIRST
	$PYTHON_COMMAND "$PYTHON_SCRIPTS_PATH/link_init.py"

	# setup for various languages
	f_setup_python
	f_setup_golang
	f_setup_cargo

	# install python package deps
	pip install --upgrade --quiet pip
	pip install --quiet -r "$DEPS_DIR_PATH/requirements.txt"

	# install brew deps
	brew update -q
	brew bundle -q --file="$DEPS_DIR_PATH/Brewfile"
	# commenting this out as it errors without sudo permissions
	# brew cleanup -q

	# install go, cargo, and npm deps
	$PYTHON_COMMAND "$PYTHON_SCRIPTS_PATH/deps_init.py"

	# make sure packer is installed for nvim
	if [ ! -d "$PACKER_NVIM_PATH" ]; then
		git clone --depth 1 https://github.com/wbthomason/packer.nvim "$PACKER_NVIM_PATH"
	fi
}

function f_setup_python() {
	echo "setting up python"
	# set up pyenv
	eval "$(pyenv install -s $PYTHON_VERSION)"
	echo "finished setting up python"
}

function f_setup_golang() {
	# NOTE: run `which go` and if you see something not set up by goenv
	# run something like this `sudo mv {go location} {go location}_backup`
	# then run `which go` again to ensure it is now set by goenv
	echo "setting up golang..."
	# set up goenv
	eval "$(goenv install -s $GO_VERSION)"
	echo "finished setting up golang"
}

function f_setup_cargo() {
	echo "setting up cargo..."
	# make sure cargo is installed
	if
		! command -v cargo &>/dev/null
	then
		echo "cargo could not be found, installing..."
		curl https://sh.rustup.rs -sSf | sh
	fi
	echo "finished setting up cargo"
}

function f_opypi() {
	open "https://pypi.org/project/$1/"
}

#########################
# ACTIVATE LOCAL CONFIG #
#########################

# THIS MUST STAY AT THE BOTTOM OF THE FILE
if [ -f "$ZSHRC_LOCAL_FILE_PATH" ]; then
	source "$ZSHRC_LOCAL_FILE_PATH"
else
	echo "NO .zshrc.local FILE FOUND!"
fi
