{ config, pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    clock24 = true;

    baseIndex = 1;
    escapeTime = 0;
    sensibleOnTop = true;

    plugins = with pkgs; [
      # tmuxPlugins.tmux-sensible
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.vim-tmux-navigator
    ];

    extraConfig = ''
      # https://old.reddit.com/r/tmux/comments/mesrci/tmux_2_doesnt_seem_to_use_256_colors/
      set -g default-terminal "xterm-256color"
      set -ga terminal-overrides ",*256col*:Tc"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set-environment -g COLORTERM "truecolor"

      # Mouse works as expected
      set-option -g mouse on
      # easy-to-remember split pane commands
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
    '';
  };
}
