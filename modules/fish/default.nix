{ pkgs, lib, ... }:
{
   programs.fish = {
    enable = true;
    interactiveShellInit = lib.strings.concatStrings (lib.strings.intersperse "\n" ([
      "set -g fish_greeting"
      "fish_vi_key_bindings"
      "set -Ux PROJECTS $HOME/git"
      "set PATH $PATH $HOME/.local/bin"
      "set -x DIRENV_LOG_FORMAT ''"
      "function fish_mode_prompt; end"
    ]));
    shellAliases = {
      cal = "cal -y";
      pbcopy = "xclip -sel c";
      i3config = "nvim ~/git/dotfiles/modules/xdg_config/i3config";

      cr = "cargo run";
      ct = "cargo test";
      cc = "cargo check";

      tn = "tmux new -s";
      tk = "tmux kill-session -t";
      ta = "tmux a -t";
      tl = "tmux ls";

      tt = "tmux-sessionizer";

      gs = "git status";
      gl = "git log";
      gp = "git pull --rebase";
      gsync = "git stash; and git pull --rebase; and git stash pop";


      usenix = "echo 'use nix' > .envrc && direnv allow";
    };
  };
}
