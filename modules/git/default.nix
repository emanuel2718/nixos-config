{ ... }:
{
  programs.git = {
    enable = true;
    userName = "emanuel2718";
    userEmail = "eramirez2718@gmail.com";
    extraConfig = {
      pull.rebase = true;
      core.editor = "nvim";
    };
  };
}
