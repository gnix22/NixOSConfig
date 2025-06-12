{ pkgs, ... }:

{
  #####################
  ### Wares of Soft ###
  #####################

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
	# utilities
	#neovim

	# hyprland
	kitty 
	wofi
	hyprpaper # wallpaper things
  hyprcursor # for cursors coolio stuff
  rose-pine-hyprcursor
	lsd

  # sound extras
  alsa-utils
  cava
  rockbox-utility
	# note taking and such
	obsidian
  vscode

  # fun things 
  cmatrix
  ];  
}
