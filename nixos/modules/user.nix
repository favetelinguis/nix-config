{ pkgs, ... }: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.henke = {
    isNormalUser = true;
    description = "henke";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
}
