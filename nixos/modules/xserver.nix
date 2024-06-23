{
	services.xserver = {
		enable = true;
 		 # Enable the GNOME Desktop Environment.
  		displayManager.gdm.enable = true;
  		desktopManager.gnome.enable = true;
		
		xkb = {
  			# Configure keymap in X11
  			variant = "";
  			layout = "us";
		};
	};
}
