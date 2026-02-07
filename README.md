# Drachh's NixOS Config

## Installation

**Retrieve hardware configuration**
```bash
cp /etc/nixos/hardware-configuration.nix ./nixos/hardware-configuration.nix
```

**Basic OS build**
```bash
sudo nixos-rebuild switch --flake .#nixOS
```

**Build & switch with nh alias**
```bash
# requires file path setup
nh os switch

# requires alias
switch
```

---

## Format

```bash
nix-shell -p nixfmt-tree

cd dotfiles

treefmt
```