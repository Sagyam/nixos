{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;

    # Starship configuration with Night Owl theme colors
    settings = {
      format = "$all$directory$character";
      add_newline = true;

      # Use Night Owl color scheme
      palette = "night_owl";

      character = {
        success_symbol = "[❯](bold #82aaff)";  # Night Owl blue
        error_symbol = "[❯](bold #ef5350)";    # Night Owl red
        vimcmd_symbol = "[❮](bold #addb67)";   # Night Owl green
      };

      directory = {
        format = "[$path]($style)[$read_only]($read_only_style) ";
        style = "bold #82aaff";
        read_only = " ";
        read_only_style = "#ef5350";
        truncation_length = 3;
        truncate_to_repo = true;
      };

      git_branch = {
        format = "on [$symbol$branch(:$remote_branch)]($style) ";
        symbol = " ";
        style = "bold #c792ea";  # Night Owl purple
      };

      git_status = {
        format = "([$all_status$ahead_behind]($style) )";
        style = "bold #ecc48d";  # Night Owl yellow
        conflicted = "=\${count}";
        ahead = "⇡\${count}";
        behind = "⇣\${count}";
        diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
        untracked = "?\${count}";
        stashed = "$\${count}";
        modified = "!\${count}";
        staged = "+\${count}";
        renamed = "»\${count}";
        deleted = "✘\${count}";
      };

      nodejs = {
        format = "via [$symbol($version )]($style)";
        symbol = " ";
        style = "#addb67";  # Night Owl green
      };

      python = {
        format = "via [$symbol$pyenv_prefix($version )(\($virtualenv\) )]($style)";
        symbol = " ";
        style = "#82aaff";  # Night Owl blue
      };

      rust = {
        format = "via [$symbol($version )]($style)";
        symbol = " ";
        style = "#f78c6c";  # Night Owl orange
      };

      golang = {
        format = "via [$symbol($version )]($style)";
        symbol = " ";
        style = "#7fdbca";  # Night Owl cyan
      };

      docker_context = {
        format = "via [$symbol$context]($style) ";
        symbol = " ";
        style = "#82aaff";  # Night Owl blue
      };

      kubernetes = {
        format = "on [$symbol$context( \($namespace\))]($style) ";
        symbol = "☸ ";
        style = "#c792ea";  # Night Owl purple
        disabled = false;
      };

      aws = {
        format = "on [$symbol($profile )(\($region\) )]($style)";
        symbol = " ";
        style = "#ecc48d";  # Night Owl yellow
      };

      cmd_duration = {
        format = "took [$duration]($style) ";
        style = "#7fdbca";  # Night Owl cyan
        min_time = 2000;
      };

      time = {
        format = "at [$time]($style) ";
        style = "#d6deeb";  # Night Owl foreground
        disabled = true;
      };

      # Define Night Owl color palette
      palettes.night_owl = {
        background = "#011627";
        foreground = "#d6deeb";
        red = "#ef5350";
        green = "#addb67";
        yellow = "#ecc48d";
        blue = "#82aaff";
        purple = "#c792ea";
        cyan = "#7fdbca";
        orange = "#f78c6c";
      };
    };
  };
}
