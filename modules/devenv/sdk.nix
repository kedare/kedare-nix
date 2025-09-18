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
  ];

}
