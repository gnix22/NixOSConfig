# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, inputs, config, lib, ... }:

{

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # test, remove if no fix
  hardware.enableAllFirmware = true;
  boot.kernelParams = [ "snd_intel_dspcfg.dsp_driver=1" ];
  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;
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
  users.users.gnix = {
    isNormalUser = true;
    description = "Garrett";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Install firefox.
  programs.firefox.enable = true;
 
  # enable udisk2 wrappers
  services.udisks2.enable = true;

  environment.systemPackages = with pkgs; [
   # back up items
   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
   lf
   # install pipewire and pulse to test since no pactl
   pipewire
   pulseaudio
   ffmpeg
   mpv
   usbutils
   udiskie
   # obs for recording assignments
   obs-studio
   pavucontrol
   #wget
  ];

  programs.steam.enable = true;
  #---Fonts---#

  fonts.packages = with pkgs; [
   mononoki
   nerd-fonts.fira-code
   font-awesome
  ];

  #experimental some such
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];  

  system.stateVersion = "24.11";
}
