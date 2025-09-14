{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    google-chrome
    wezterm
    vscode
    ffmpeg-full
    vlc
    yt-dlp
  ];

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      fira-sans
      nerd-fonts._0xproto
      nerd-fonts.fira-code
      nerd-fonts.droid-sans-mono
    ];
    fontconfig = {
      defaultFonts = {
        monospace = [ "0xProto Nerd Font" ];
        sansSerif = [ "Fira Sans" ];
        serif = [ "DejaVu Serif" ];
      };
    };
  };

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "kedare" ];
  };
  programs.firefox.enable = true;
}
