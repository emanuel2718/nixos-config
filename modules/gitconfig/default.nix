{ pkgs, ... }:
let
  rg = "${pkgs.ripgrep}/bin/rg";
in {
 programs.git = {
    enable = true;
    userName = "Emanuel Ramirez";
    userEmail = "eramirez2718@gmail.com";
    extraConfig = {
      color.ui = true;
      github.user = "emanuel2718";
      init.defaultBranch = "master";
      pull.rebase = true;
      core = {
        editor = "nvim";
        pager = "diff-so-fancy | less --tabs=4 -RFX";
      };
    };
    aliases = {
      prettylog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
      fixup = "!f(){ git reset --soft HEAD~\${1} && git commit --amend -C HEAD; };f";
      loc = "!f(){ git ls-files | ${rg} \"\\.\${1}\" | xargs wc -l; };f"; # lines of code
    };
    #signing = {
    #  key = "";
    #  signByDefault = true;
    #};
  };

}
