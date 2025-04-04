{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    fortune
    zoxide
  ];

  # set fish as the defacto default shell
  programs.bash = {
    enable = true;

    # TODO
    # 	initExtra = ''
    # 		if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
    # 		then
    # 			shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
    # 			exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
    # 		fi
    # 	'';
    initExtra = ''
      shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
      exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
            		'';
  };

  programs.fish = {
    enable = true;

    # TODO /Users/klim should be something else
    interactiveShellInit = ''
            			function fish_greeting
            				fortune
            			end

            			set fish_user_paths ~/.cargo/bin $fish_user_paths
      						set fish_user_paths ~/.deno/bin $fish_user_paths
      						set fish_user_paths ~/.config/emacs/bin $fish_user_paths
      						set fish_user_paths /Applications/ti/ti-cgt-armllvm_4.0.2.LTS/bin

            			zoxide init fish | source
            		'';
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  home.shellAliases = {
    e = "ls -lh";
    ea = "ls -lah";
    cd = "z";
    n = "nvim";
    preview = "open -a Preview";
    # TODO: Not great only should be done on mac
    python = "/run/current-system/sw/bin/python3";
    python3 = "/run/current-system/sw/bin/python3";
  };
}
