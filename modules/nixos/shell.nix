{
  pkgs,
  ...
}:

{

  i18n.defaultLocale = "en_US.UTF-8";

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
    };
  };

  users.defaultUserShell = pkgs.zsh;
  programs.starship.enable = true;
}
