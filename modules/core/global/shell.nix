{
  pkgs,
  ...
}:

{
  environment.shellAliases = {
    y2mp3 = "youtube-dl -x --audio-format mp3 --xattrs --audio-quality 7 --add-metadata --embed-thumbnail";
    gco = "git commit";
    gps = "git push";
    gpl = "git pull";
    gs = "git status";
    glg = "git log";
    ga = "git add";
    gaa = "git add -A";
    gcl = "git clone";
    gd = "git diff";
    gdc = "git diff --cached";
    gcs = "git clone --depth=1";
    gcam = "git commit -am";
    gchm = "git checkout \$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')";
    gca = "git add -A";
    gcb = "git checkout -b";
    ggc = "git gc --force --aggressive";
    e = "emacsclient -t";
    edm = "emacs --daemon";
    aras = "ara-manage runserver";
    tf = "terraform";
    cat = "bat";
    wt = "watch -n1 $(fc -ln -1)";
    k = "kubectl";
    lsx = "exa -lha --git";
  };

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
