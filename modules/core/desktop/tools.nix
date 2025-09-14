{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    google-chrome
    vscode
  ];

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "kedare" ];
  };
  programs.firefox.enable = true;
}
