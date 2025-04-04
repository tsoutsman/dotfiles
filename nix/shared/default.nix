{
  pkgs,
  config,
  nix,
  nixpkgs,
  system,
  inputs,
  self,
  ...
}:
{
  imports = [
    inputs.home-manager.darwinModules.home-manager
  ];

  system.stateVersion = 5;
  system.configurationRevision = self.rev or self.dirtyRev or null;

  nix.settings.experimental-features = "nix-command flakes";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ inputs.rust-overlay.overlays.default ];

	services.postgresql = {
		enable = true;
	};

  fonts.packages = with pkgs; [
    jetbrains-mono
  ];

  environment.systemPackages = with pkgs; [
    (python313.withPackages (
      p: with p; [
				beautifulsoup4
				matplotlib
        numpy
        pandas
        polars
				requests
				statsmodels
      ]
    ))
  ];

  users.users.klim = {
    description = "Klimenty Tsoutsman";
    # extraGroups = ["networkmanager" "wheel"];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.klim = import ./../home-manager/default.nix;
  };
}
