{ config, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;

    settings = {
      # Font configuration
      font-family = "Intel One Mono";
      font-size = 16;

      # Window appearance
      background-opacity = 1.0;
      background-blur = 0;
      alpha-blending = "native";
      maximize = true;

      # Night Owl theme colors
      # Based on Sarah Drasner's Night Owl VS Code theme
      background = "011627";
      foreground = "d6deeb";
      cursor-color = "80a4c2";
      selection-background = "1d3b53";
      selection-foreground = "d6deeb";

      # Black
      palette = [
        "0=011627"  # black
        "1=ef5350"  # red
        "2=addb67"  # green
        "3=ecc48d"  # yellow
        "4=82aaff"  # blue
        "5=c792ea"  # magenta
        "6=7fdbca"  # cyan
        "7=d6deeb"  # white

        # Bright colors
        "8=575656"  # bright black
        "9=f78c6c"  # bright red
        "10=addb67" # bright green
        "11=ffeb95" # bright yellow
        "12=82aaff" # bright blue
        "13=c792ea" # bright magenta
        "14=7fdbca" # bright cyan
        "15=ffffff" # bright white
      ];
    };
  };
}
