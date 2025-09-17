{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [

    # CLI utilities
    bat
    fd
    ripgrep
    neofetch
    jq
    yq-go
    eza
    fzf
    file
    which
    tree
    gnutar
    gawk
    gnupg
    tokei

    # Nix related tools
    nil
    nixd
    nixfmt-rfc-style
    direnv

    # HTTP clients
    wget
    curl
    httpie

    # Monitoring
    htop
    btop
    iotop
    iftop
    ncdu
    sysstat
    lm_sensors
    dnsutils
    strace
    lsof
    ltrace
    sysstat
    pciutils
    usbutils
    tcpdump

    # Backup
    kopia

    # Archiving
    zip
    xz
    unzip
    p7zip
    zstd

    # Basic development tools
    git
    vim
    go-task
    lunarvim
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

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.fwupd.enable = true;
}
