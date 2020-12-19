{ config, pkgs, ... }:

let mypolybar = pkgs.polybar.override {
    mpdSupport = true;
    pulseSupport = true;
  };
in
  {
programs.home-manager.enable = true;
  home.packages = with pkgs;  [
    # cli tools
    exa
    bat
    fd
    ripgrep
    tealdeer
    starship
    github-cli

    # Development
    neovim
    tmux
    fzf
    nodejs
    rustup
    alacritty
    ruby

    # Media
    brave
    firefox
    youtube-dl
    musescore

    obs-studio

    zoom-us

    imagemagick
    sxiv
    maim
    xclip
    xsel
    zathura
    nerdfonts
    slock
    ffmpeg
    feh
    mpv
    pulsemixer
    pamixer
    flameshot
    newsboat
    zulip
    libreoffice

    # Overview
    htop
    neofetch
    dmenu
    killall
    sxhkd
    arandr

    # misc
    dconf
  ];


  programs.bash = {
    enable = true;
    shellAliases = {
      cp=''cp -iv'';
      mv=''mv -iv'';
      rm=''rm -v'';
      mkd=''mkdir -pv'';
      yt=''youtube-dl --add-metadata -i'';
      yta=''yt -x -f bestaudio/best'';
      ffmpeg=''ffmpeg -hide_banner'';
      mail=''neomutt'';
      ls=''exa'';
      la=''exa -a'';
      al=''exa -a'';
      ll=''exa -l'';
      l=''exa -la'';
      tree=''exa -T'';
      grep=''rg'';
      psg=''ps -A | grep -i'';
      psf=''ps -A | fzf'';
      gacp=''git add . ; git commit -a ; git push'';
      g=''git'';
      gis=''git status'';
      gac=''git add . ; git commit -a'';
      gr=''cd \`git rev-parse --show-toplevel\`'';
      diff=''diff --color=auto'' ;
      ka=''killall'' ;
      sl=''ls'' ;
      sdn=''sudo shutdown -h now'' ;
      doas=''sudo'';
      du=''du -h'' ;
      df=''df -h'' ;
      e =''exit'' ;
      c =''clear'' ;
      vim=''nvim'';
      cu=''cd ..'' ;
      fd=''fd --no-ignore'';
      t=''tmux'';
      ta=''tmux a'';
      tl=''tmux ls'';
      ca=''cargo'';
      cfnix=''cd ~/.config/nixpkgs&&nvim home.nix'';
    };
    initExtra = ''
      if [ -n "$TMUX" ]; then
        tmux set -a window-active-style "bg=#1C1C1C"
        tmux set -a window-style "bg=#282828"
        # tmux set -g pane-active-border-style "bg=#1C1C1C"
        # tmux set -g pane-border-style "bg=#282828"
      fi

      dev() {
        cd ~/dev/$1
        nix-shell ~/env/$1.nix
      }

      # for starship prompt
      eval "$(starship init bash)"
    '';
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.gnome3.gnome_themes_standard;
      name = "Adwaita Dark";
    };
  };

  programs.git = {
    enable = true;
    userEmail = "jacoblevgw@gmail.com";
    userName = "g-w1";
    extraConfig = {
      credential = {
        helper="cache --timeout=36000";
      };
      pull = {
        rebase = false;
      };
    };
  };

  programs.tmux.enable = true;

  home.file = {
	  ".tmux.conf".source = ./tmux.conf;
	  ".xinitrc".source = ./xinitrc;
	  ".profile".source = ./profile;
	  ".local/bin".source = ./scripts;
	  ".local/bin".recursive = true;
	  ".config/starship.toml".source = ./starship.toml;
  };

  xdg.configFile = {
	  "nvim/init.vim".source = ./init.vim;
	  "input/inputrc".source = ./inputrc;
	  "alacritty/alacritty.yml".source = ./alacritty.yml;
	  "newsboat/config".source = ./news_cfg;
	  "zathura/zathurarc".source = ./zathurarc;
	  "bspwm/bspwmrc".source = ./bspwmrc;
	  "sxhkd/sxhkdrc".source = ./sxhkdrc;
  };

  services.polybar = {
    enable = true;
    package = mypolybar;
    config = ./polybar;
    script = ''
      launch_polybar&
    '';
  };
}
