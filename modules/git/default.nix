{ pkgs, ... }: {
 programs.git = {
    enable = true;
    userName = "Emanuel Ramirez";
    userEmail = "eramirez2718@gmail.com";
    extraConfig = {
      color.ui = true;
      github.user = "emanuel2718";
      init.defaultBranch = "master";
    };
    aliases = {
      prettylog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
    };
    #signing = {
    #  key = "";
    #  signByDefault = true;
    #};
  };

}
