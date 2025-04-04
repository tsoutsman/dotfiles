{ config, pkgs, ... }:
{
  services.emacs = {
    enable = true;
  };

  programs.emacs = {
    enable = true;
  };

  home.packages = with pkgs; [
    binutils
    gnutls
    ispell
  ];
}
