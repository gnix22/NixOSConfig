{ pkgs, inputs, system, ... }:

{
  #####################
  ### Wares of Soft ###
  #####################

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
	# utilities
	neovim
	udiskie

	# hyprland
	kitty 
	wofi
	hyprpaper # wallpaper things
	lsd

	# note taking and such
	obsidian
        vscode
  ];  
}
