To build and switch

```shell
# check and lint
nixfmt **/**.nix

# Build for local system
task build

# Switch to latest config on local system
task switch

# Low level usage: Here on garuda for example (only needed if task is not available, during bootstrap, etc..)
nixos-rebuild build --flake .#garuda
sudo nixos-rebuild switch --flake .#garuda
```
