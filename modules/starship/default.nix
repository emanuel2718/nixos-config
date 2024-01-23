{ pkgs, ... }: {
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      command_timeout = 1000;
      directory = {
        truncation_length = 1;
        fish_style_pwd_dir_length = 1;
      };
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
      git_status = {
        disabled = true;
      };
    };
  };
}
