To build and switch

```shell
# check and lint
nixfmt **/**.nix

# Here on garuda for example
nixos-rebuild build --flake .#garuda
sudo nixos-rebuild switch --flake .#garuda
```
