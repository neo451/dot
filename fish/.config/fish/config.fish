alias zi "NVIM_APPNAME=zh-nvim nvim"
alias maiden "maiden-remote-repl --host 192.168.43.179"
alias bat batcat
alias mvi "~/neov/bin/nvim"
#alias scsynth "/usr/bin/scsynth"
alias sclang "/mnt/d/audio-software/sclang.exe"
alias scsynth "/mnt/d/audio-software/scsynth"
alias vi nvim
alias em "emacs -nw"
alias lua "lua5.1"
alias ts tree-sitter
alias py '/usr/bin/python3.10'
alias zbr 'zig build run'
alias c clear
alias inv 'nvim $(fzf --preview="bat {} --color=always")'
alias fsh 'bash /home/n451/.config/scripts/fsh'
alias fua 'bash /home/n451/.config/scripts/fua'
alias ls 'exa -lah'
fzf --fish | source

alias nb 'busted --lua=nlua'

fish_add_path ~/wabt-1.0.3/bin
fish_add_path ~/nvim/nvim-linux64/bin/
fish_add_path ~/.idris2/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.luau
fish_add_path ~/im-select
fish_add_path /snap/bin
fish_add_path ~/.config/emacs/bin
fish_add_path ~/.local/bin
fish_add_path ~/.ghcup/bin
fish_add_path ~/.local/share/nvim/mason/bin
fish_add_path ~/julia-1.8.1/bin
fish_add_path /usr/local/go/bin
fish_add_path ~/go/bin
fish_add_path ~/.zig
fish_add_path ~/.gleam
fish_add_path ~/lua
set DENO_INSTALL "/home/n451/.deno"
set PATH "$DENO_INSTALL/bin:$PATH"
set MODULAR_HOME "/home/n451/.modular"
set PATH "/home/n451/.modular/pkg/packages.modular.com_mojo/bin:$PATH"
fish_add_path ~/roc_nightly-linux_x86_64-2024-07-13-070d14a

starship init fish | source
set -e XDG_RUNTIME_DIR
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
set -gx PATH $HOME/.cabal/bin $PATH /home/n451/.ghcup/bin # ghcup-env

# opam configuration
#zoxide init fish | source
source /home/n451/.opam/opam-init/init.fish >/dev/null 2>/dev/null; or true

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# Setting PATH for Eurorack-blocks/Erbb
source /home/n451/eurorack-blocks/build-system/init.fish

# Generated for envman. Do not edit.
test -s ~/.config/envman/load.fish; and source ~/.config/envman/load.fish
