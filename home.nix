{ config, pkgs, ... }:

let
  mypolybar = pkgs.polybar.override {
    mpdSupport = true;
    pulseSupport = true;
  };
  work = (pkgs.callPackage ./work.nix { }).rootCrate.build;
in {
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    # cli tools
    exa
    less
    fd
    ripgrep
    tealdeer
    starship
    github-cli
    work
    xdotool
    black
    aerc
    amfora # gemini
    file
    zip
    unzip
    xxd
    slop
    wmctrl
    xmenu

    # Development
    neovim
    tmux
    screen
    fzf
    nodejs
    sbcl
    python38
    rustup
    go
    alacritty
    foot
    ruby
    kakoune
    parinfer-rust
    ocamlformat
    # plan9port # NICE

    # language servers
    rust-analyzer
    clang-tools
    python38Packages.python-language-server
    python38Packages.pyls-mypy
    kak-lsp

    # Media
    brave
    firefox
    youtube-dl
    musescore
    lame
    kdenlive
    jq

    obs-studio

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
    wmname # for java stuff
    gnutls # irc in emacs!
    w3m
    anki
    # mu isync # mail in emacs
    ispell # spelling in emacs
  ];

  programs.bash = {
    enable = true;
    historyFileSize = 100000000;
    shellAliases = {
      gemini="amfora";
      cp = "cp -iv";
      xd = "xxd";
      dev = "exec dev";
      sa = "screen -x";
      mv = "mv -iv";
      rm = "rm -v";
      mkd = "mkdir -pv";
      yt = "youtube-dl --add-metadata -i";
      yta = "yt -x -f bestaudio/best";
      ffmpeg = "ffmpeg -hide_banner";
      mail = "neomutt";
      ls = "exa";
      la = "exa -a";
      al = "exa -a";
      ll = "exa -l";
      l = "exa -la";
      lc = "exa";
      tree = "exa -T";
      grep = "rg";
      psg = "ps -A | grep -i";
      psf = "ps -A | fzf";
      gacp = "git add . ; git commit -a ; git push";
      g = "git";
      gis = "git status";
      gd = "git diff";
      gac = "git add . ; git commit -a";
      diff = "diff --color=auto";
      ka = "killall";
      sl = "ls";
      sdn = "sudo shutdown -h now";
      doas = "sudo";
      du = "du -h";
      df = "df -h";
      e = "exit";
      c = "clear";
      vim = "$EDITOR";
      cu = "cd ..";
      fd = "fd --no-ignore";
      t = "tmux";
      ta = "tmux a";
      tl = "tmux ls";
      ca = "cargo";
      cfnix = "cd ~/.config/nixpkgs&&$EDITOR home.nix";
      clbin = "curl --data-binary @- https://paste.rs/";
      pastebin = "xclip -selection clipboard -o | clbin";
      mu-init =
        "mu init --maildir=~/.mail/ --my-address=jacoblevgw@gmail.com --my-address=goldman-wetzlerj24@learn.hohschools.org";
      zissue = "ghissue ziglang/zig";
    };
    initExtra = ''
      HISTSIZE=100000000
      function ? {
        w3m "https://ddg.gg/?q=$(echo $@)"
      }
      function sexit {
        setsid -f $@
        sleep 1
        ps -A | grep $1 && exit
      }
      function launch {
        setsid -f $@
      }
      function gr {
        cd "$(git rev-parse --show-toplevel)"
      }
      if [ -n "$TMUX" ]; then
          tmux set -a window-active-style "bg=#1C1C1C"
          tmux set -a window-style "bg=#282828"
          # tmux set -g pane-active-border-style "bg=#1C1C1C"
          # tmux set -g pane-border-style "bg=#282828"
      fi

      if [ $TERM = "dumb" ]; then
          export PS1="% "
          export NO_COLOR=1
          alias ls="9 ls"
          alias lc="9 lc"
          alias rg="rg --vimgrep"
          function % {
            $@
          }
      else
          # for starship prompt
          eval "$(starship init bash)"
          function ❯ {
            $@
          }
      fi
      if [ -n "$INSIDE_EMACS" ]; then
      	export EDITOR=emacsclient
      fi
      ## If inside Acme...
      if [ "$winid" ]; then
        export EDITOR=editinacme
        ## ... then patch the `cd` command
        _cd () {
          \cd "$@" && awd
        }
        alias cd=_cd
      fi
      if [ -n "$TMUX" ]; then
        export EDITOR=kak
      fi
      work ls
      set -h
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
    package = pkgs.gitAndTools.gitFull;
    enable = true;
    userEmail = "jacoblevgw@gmail.com";
    userName = "g-w1";
    extraConfig = {
      credential = { helper = "cache --timeout=36000"; };
      pull = { rebase = false; };
      merge = { conflictstyle = "diff3"; };
    };
  };
  programs.opam = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.tmux.enable = true;
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
  };
  programs.emacs = { enable = true; };

  home.file = {
    ".tmux.conf".source = ./tmux.conf;
    ".screenrc".source = ./screenrc;
    ".xinitrc".source = ./xinitrc;
    ".profile".source = ./profile;
    ".local/bin".source = ./scripts;
    ".local/bin".recursive = true;
    ".local/share/emoji".source = ./emoji;
    ".config/nvim/coc-settings.json".source = ./coc-settings.json;
    ".config/starship.toml".source = ./starship.toml;
    ".npmrc".source = ./npmrc;
    ".mbsyncrc".source = ./mbsyncrc;
  };

  xdg.configFile = {
    "nvim/init.vim".source = ./init.vim;
    "input/inputrc".source = ./inputrc;
    "alacritty/alacritty.yml".source = ./alacritty.yml;
    "newsboat/config".source = ./news_cfg;
    "zathura/zathurarc".source = ./zathurarc;
    "bspwm/bspwmrc".source = ./bspwmrc;
    "sxhkd/sxhkdrc".source = ./sxhkdrc;
    "sxhkd/shodsxhkdrc".source = ./shodsxhkdrc;
    "worktodo/worktodo.toml".source = ./worktodo.toml;
    "kak".source = ./kak;
    "kak".recursive = true;
    "kak-lsp/kak-lsp.toml".source = ./kak-lsp.toml;
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
