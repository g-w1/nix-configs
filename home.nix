{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Rust CLI Tools! I love rust.
    exa
    bat
    tokei


    # Development
    neovim
    tmux
    fzf

    # Media
    youtube-dl
    imagemagick

    # Overview
    htop
    neofetch
  ];

  programs.git = {
    enable = true;
    userEmail = "jacoblevgw@gmail.com";
    userName = "g-w1";
  };
}
