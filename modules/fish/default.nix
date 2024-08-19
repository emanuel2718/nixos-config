{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting
      fish_vi_key_bindings
      set -x DIRENV_LOG_FORMAT ""
      function fish_mode_prompt; end
      ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
    '';
    shellAliases = {
      pbcopy = "xclip -sel c";

      # git
      gs = "git status";
      gl = "git log";
      gsync = "git stash; git pull --rebase; git stash pop";

      # cargo
      cr = "cargo run";
      ct = "cargo test";
      cc = "cargo check";

      # tmux
      tn = "tmux new -s";
      tk = "tmux kill-session -t";
      ta = "tmux a -t";
      tl = "tmux ls";

      tt = "sesh connect $(sesh list | fzf)";

      usenix = "echo 'use nix' > .envrc && direnv allow";
    };
  };
}
