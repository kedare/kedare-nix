{...}:

{
    environment.systemPackages = with pkgs; [
      google-chrome
    ];

    programs._1password.enable = true;
    programs._1password-gui.enable = true;
    programs.firefox.enable = true;
}
