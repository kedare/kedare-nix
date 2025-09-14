{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
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
  ];

}
