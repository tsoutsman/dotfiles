{ pkgs, config, ... }:
{
  nix-homebrew = {
    enable = true;
    enableRosetta = true;

    user = "klim";
  };

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };

    # https://github.com/zhaofengli/nix-homebrew/issues/5#issuecomment-1878798641
    # taps = builtins.attrNames config.nix-homebrew.taps;
    taps = [
      "homebrew/homebrew-core"
      "homebrew/homebrew-cask"
      "homebrew/homebrew-bundle"
      "3kwa/minion"
    ];
    brews = [
      "arm-none-eabi-gdb"
			"libpq"
      # {
      # 	name = "minion";
      # 	args = [ "no-quarantine" ];
      # }
      "pinentry-mac"
    ];
    casks = [
      # "arc"
      "discord"
      # "iterm2"
      "kitty"
      # "mactex"
      "spotify"
      "unnaturalscrollwheels"
    ];
    masApps = {
      # tailscale = 1475387142;
    };
  };
}
