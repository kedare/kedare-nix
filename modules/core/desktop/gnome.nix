{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
    desktopManager.gnome = {
      enable = true;
      extraGSettingsOverridePackages = [ pkgs.mutter ];
      extraGSettingsOverrides = ''
        [org.gnome.mutter]
        experimental-features=['scale-monitor-framebuffer', 'xwayland-native-scaling']
      '';
    };
  };

  environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnomeExtensions.forge
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.tailscale-status
  ];
}
