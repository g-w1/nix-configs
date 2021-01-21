# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader. Make sure your on a modern system
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # clean /tmp on boot by mounting in tmpfs
  boot.tmpOnTmpfs = true;

  networking.hostName = "dell"; # Define your hostname, change this

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = true;
  networking.interfaces.wlp2s0.useDHCP = true;
  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "colemak";
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  security = {
    sudo.enable = true;
    sudo.wheelNeedsPassword = false;
  };
  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    wget neovim curl exa git
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.avahi.enable = true; 

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver= {
	  enable = true;
	  layout = "us";
	  xkbVariant = "colemak";
	  xkbOptions = "caps:backspace";
  };

  # Enable bspwm
  services.xserver.windowManager.bspwm = {
    enable = true;
  };

  # enable no displaymanager
  services.xserver.displayManager.startx.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’. 
  users.users.jacob = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" ]; # Enable ‘sudo’ for the user.
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?
 
  # add slock to the oom killers so I can actually use
  security.wrappers.slock.source = "${pkgs.slock.out}/bin/slock";

  # unfree software
  nixpkgs.config.allowUnfree = true;
  networking.extraHosts = 
  ''
192.168.1.124 bruh
  '';

}

