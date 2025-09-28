{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    gnumake
    clang
    gcc
    go
    gox
    delve
    golangci-lint
    gopls
    gotests
    impl
    python3Full
    ruby_3_4
    zulu24
    perl
    postgresql
    postgresql.pg_config
    libpq
    terraform
    qemu
  ];

#  programs.virt-manager.enable = true;
#  users.groups.libvirtd.members = ["kedare"];
#  virtualisation.libvirtd.enable = true;
#  virtualisation.spiceUSBRedirection.enable = true;

}
