set -g fish_greeting
fish_vi_key_bindings
function fish_mode_prompt; end


set -gx EDITOR nvim


abbr -a tk 'tmux kill-session -t'
abbr -a ta 'tmux a -t'
abbr -a tn 'tmux new -s'
abbr -a tl 'tmux ls'

alias fnix "nix-shell --run fish"

set -q PATH; or set PATH ''; set -gx PATH  "$HOME/.local/bin" $PATH;


