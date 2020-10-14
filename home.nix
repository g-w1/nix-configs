{ config, pkgs, ... }:

{
programs.home-manager.enable = true;
  home.packages = with pkgs; [
    # cli tools
    exa
    bat


    # Development
    neovim
    tmux
    fzf
    nodejs

    rustup

    # Media
    youtube-dl
    imagemagick
    sxiv
    maim
    xclip
    xsel
    zathura


    # Overview
    htop
    neofetch
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
	YT=''youtube-viewer -C -7'' ;
	sdn=''sudo shutdown -h now'' ;
	doas=''sudo'';
	du=''du -h'' ;
	e =''exit'' ;
	c =''clear'' ;
	vim=''nvim'';
	cu=''cd ..'' ;
	fd=''fd --no-ignore'';
	t=''tmux'';
	ta=''tmux a'';
};
  };

  programs.git = {
    enable = true;
    userEmail = "jacoblevgw@gmail.com";
    userName = "g-w1";
  };
  programs.tmux.enable = true;

  home.file = {
  ".tmux.conf".source = ./tmux.conf;
  ".profile".source = ./profile;
  ".local/bin".source = ./scripts;
  ".local/bin".recursive = true;
  };

  xdg.configFile = {
	  "polybar/config".source = ./polybar;
	  "nvim/init.vim".source = ./init.vim;
    "input/inputrc".source = ./inputrc;
    "zathura/zathurarc".source = ./zathurarc;
  };
}
