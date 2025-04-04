{ pkgs, config, ... }:
{
  services.skhd = {
    enable = false;
    skhdConfig = builtins.readFile ../../config/skhd/skhdrc;
  };

  services.yabai = {
    enable = true;
  };
}
