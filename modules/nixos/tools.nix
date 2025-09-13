{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    wget
    curl
    nil
    btop
    ncdu
    bat
    fd
    ripgrep
    htop
    git
    vim
    sysstat
    kopia
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
  };

  programs.htop = {
    enable = true;
    settings = {
      hide_kernel_threads = false;
      hide_userlands_threads = false;
    };
  };
}
