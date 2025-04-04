{ config, pkgs, ... }:
{
  programs.gh = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Klim Tsoutsman";
    userEmail = "klim@tsoutsman.com";

    extraConfig = {
      commit.gpgsign = true;
      user.signingkey = "3CB61BD07014B2D7D150EF5C5C5E34C6B890E6F8";
      gpg.program = "gpg";

      push.autoSetupRemote = true;
      color.ui = "auto";

      init.defaultBranch = "main";
    };

    difftastic = {
      enable = true;
    };

    ignores = [
      ".idea/"
      ".DS_Store"
    ];
  };
}
