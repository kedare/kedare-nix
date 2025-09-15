To build and switch

```shell
# check and lint
nixfmt **/**.nix

# Build for local system
task build

# Deploy on local system
task deploy

# Low level usage: Here on garuda for example (only needed if task is not available, during bootstrap, etc..)
nixos-rebuild build --flake .#garuda
sudo nixos-rebuild switch --flake .#garuda
```
