# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

  let background-sddm = pkgs.stdenvNoCC.mkDerivation {
  	name = "SDDM-rat_bg";
	src = sddm-bg/biohazard_2_blur.png;
	dontUnpack = true;
	installPhase = '' cp $src $out '';
      };
  in
  {
  imports = [ ];#<home-manager/nixos> ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
 networking.hostName = "Antares"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.hosts = {
  	"100.108.199.83" = [ "sirius.lagartao.gay" ];
  };

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;



  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  services.displayManager = {
  	sddm = {
  		enable = true;
  		settings = {
  			AutoLogin = {
  				Session = "xfce";
  				User = "niko";
  			};
  		};
  		theme = "breeze";
  	};
  };

  # Configure keymap in X11
  services.xserver = {
  	xkb = {
    		layout = "br";
    		variant = "abnt2";
  	};
	desktopManager.xfce.enable = true;
  	desktopManager.xterm.enable = false;
	displayManager.lightdm = {
  		enable = false;
		greeters.gtk.enable = true;
		background = /home/niko/Wallpapers/biohazard_2_blur.png;
		greeters.gtk.extraConfig = "default-user-background=false";
		greeters.gtk.iconTheme.name = "Tango";
		extraConfig = "greeter-hide-users=false";
  	};
	
  };

  environment.systemPackages = with pkgs; [
  	kitty
	(writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
			[General]
			background=${background-sddm}		'')
	# (callPackage ../loose-wm/wm.nix {})
	#xorg.libX11
  	#  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  	#  wget
  	];

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.niko = {
    isNormalUser = true;
    description = "Niko";
    home = "/home/niko";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    telegram-desktop
    discord
    krita
    libgcc
    gdb
    cmake
    rofi-wayland
    xwayland
    nx-libs
    parsec-bin
    simple64
    # bluez
    #  thunderbird
    ];
  };

  # The state version is required and should stay at the version you
  # originally in  # Install firefox.
  programs.firefox.enable = true;

  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;

  services.picom = {
  	enable = true;
	backend = "glx";
	shadow = false;
	inactiveOpacity = 0.9;
	settings = {
		blur = {
			method = "gaussian";
    			size = 10;
    			deviation = 5.0;
		};
		blur-background-exclude = [ "!focused" ];
	};
  };

  # for the breeze theme
  services.desktopManager.plasma6.enable = true;
  services.tailscale.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}

