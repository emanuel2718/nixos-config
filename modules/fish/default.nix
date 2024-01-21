{ pkgs, lib, ... }:
{
   programs.fish = {
    enable = true;
    interactiveShellInit = lib.strings.concatStrings (lib.strings.intersperse "\n" ([
      "set -g fish_greeting"
      "fish_vi_key_bindings"
    ]));
    shellAliases = {
      cal = "cal -y";
      pbcopy = "xclip -selection -c";

      cr = "cargo run";
      ct = "cargo test";
      cc = "cargo check";

      gsync = "git stash; and git pull --rebase; and git stash pop";
      gs = "git status";
      gl = "git prettylog";
      gpr = "git pull --rebase";

      neovim = "NVIM_APPNAME=NeoVim nvim";

    };
  };
}
