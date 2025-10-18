{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    gnumake
    clang
    llvmPackages.libcxxClang
    gcc
    go
    gox
    delve
    golangci-lint
    gopls
    gotests
    impl
    python313Full
    python313Packages.pip
    python313Packages.virtualenv
    poetry
    uv
    ruby_3_4
    zulu24
    perl
    postgresql
    postgresql.pg_config
    libpq
    terraform
    qemu
    nodejs_24
    libyaml
    libyaml.dev
    act
  ];

  # Ensure common native builds (Ruby gems, Rust bindgen) can find required headers/libs.
  environment.shellInit = ''
    export CPATH=${pkgs.libyaml.dev}/include''${CPATH:+:$CPATH}
    export LIBRARY_PATH=${pkgs.libyaml}/lib''${LIBRARY_PATH:+:$LIBRARY_PATH}
    export LIBCLANG_PATH=${pkgs.llvmPackages.libclang.lib}/lib
  '';

  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["kedare"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  virtualisation.docker = {
    enable = true;
  };

  users.users.kedare.extraGroups = [ "docker" ];
}
