let
  rustTargets = [
    "thumbv6m-none-eabi"
    "x86_64-unknown-none"
  ];
in
{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./program/emacs.nix
    ./program/git.nix
    ./program/neovim.nix
    ./program/shell.nix
    ./program/tmux.nix
  ];

  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    anki-bin
    bat
    black
    deno
		diesel-cli
    dune_3
    entr
    exercism
    fd
    fswatch
    gnupg
		neofetch
    neovide
    nil
    nixfmt-rfc-style
		nodejs_23
    ocaml
    ocamlformat
    ocamlPackages.ocaml-lsp
		pandoc
		postgresql
    quarto
    ripgrep
    # rustup
    tree
    treefmt
    typst
    uv

    (pkgs.rust-bin.selectLatestNightlyWith (
      toolchain:
      toolchain.default.override {
        extensions = [ "rust-analyzer" ];
        targets = rustTargets;
      }
    ))
  ];

  home.file = {
    ".config/yabai".source = ../../config/yabai;
    ".config/kitty".source = ../../config/kitty;
  };

  programs.home-manager.enable = true;
}
