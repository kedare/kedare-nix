# Infrastructure Configuration with Ansible

This repository contains Ansible automation for managing Ubuntu 24.04 LTS infrastructure across desktop, laptop, and server machines.

## Overview

This Ansible configuration manages:
- **3 Desktop/Laptop machines**: garuda (Framework 13 AMD), bahamut (workstation), carbuncle (HTPC)
- **2 Server machines**: esbcn1-nas1 (NAS), esbcn1-nix-cache1 (cache server)

## Prerequisites

### Control Machine

Install Ansible on your control machine (the machine from which you'll run Ansible):

```bash
# Ubuntu/Debian
sudo apt update
sudo apt install ansible

# macOS
brew install ansible

# Python pip
pip3 install ansible
```

### Target Machines

Fresh Ubuntu 24.04 LTS installations with:
- SSH server installed and running
- A user account with sudo privileges
- Python 3 installed (comes with Ubuntu 24.04)

## Initial Setup

### 1. Clone the Repository

```bash
git clone <repository-url>
cd kedare-ansible
```

### 2. Install Ansible Galaxy Dependencies

```bash
ansible-galaxy install -r requirements.yml
ansible-galaxy collection install -r requirements.yml
```

### 3. Configure Inventory

Edit `inventory/hosts.yml` to match your infrastructure:

```yaml
all:
  children:
    desktops:
      hosts:
        garuda:
          ansible_host: garuda.local  # Update with actual hostname/IP
        # ... other hosts
```

### 4. Set Up SSH Access

Ensure you have SSH access to all target machines:

```bash
# Test connectivity
ansible all -m ping

# If you need to copy SSH keys
ssh-copy-id user@hostname
```

### 5. Configure Variables

#### Global Variables

Edit `inventory/group_vars/all.yml`:

```yaml
# Update Tailscale auth key if using Tailscale
tailscale_authkey: "tskey-auth-xxxxx"

# Update SSH keys URL or disable
ssh_keys_url: https://codeberg.org/kedare.keys
```

#### Host-Specific Variables

Review and update files in `host_vars/` for each machine.

## Usage

### Bootstrap New Machines

For freshly installed Ubuntu 24.04 systems:

```bash
ansible-playbook playbooks/bootstrap.yml
```

This will:
- Update all packages
- Install Python dependencies
- Reboot if necessary

### Configure All Machines

```bash
ansible-playbook playbooks/site.yml
```

### Configure Specific Host Groups

```bash
# Desktops only
ansible-playbook playbooks/desktops.yml

# Servers only
ansible-playbook playbooks/servers.yml

# Specific host
ansible-playbook playbooks/site.yml --limit garuda
```

### Run Specific Roles/Tags

```bash
# Only install common packages
ansible-playbook playbooks/site.yml --tags common

# Only configure desktop environment
ansible-playbook playbooks/desktops.yml --tags desktop

# Only setup gaming software
ansible-playbook playbooks/desktops.yml --tags gaming

# Only configure NAS
ansible-playbook playbooks/servers.yml --tags nas
```

### Test Connectivity

```bash
ansible-playbook playbooks/test.yml
```

## Project Structure

```
.
├── ansible.cfg                 # Ansible configuration
├── requirements.yml            # Galaxy roles and collections
├── inventory/
│   ├── hosts.yml              # Host definitions
│   └── group_vars/
│       ├── all.yml            # Global variables
│       ├── desktops.yml       # Desktop-specific variables
│       └── servers.yml        # Server-specific variables
├── host_vars/
│   ├── garuda.yml             # Per-host variables
│   ├── bahamut.yml
│   ├── carbuncle.yml
│   ├── esbcn1-nas1.yml
│   └── esbcn1-nix-cache1.yml
├── roles/
│   ├── common/                # Base system configuration
│   ├── desktop/               # GNOME desktop environment
│   ├── devenv/                # Development tools
│   ├── gaming/                # Steam, Heroic
│   ├── server/                # Server-specific config
│   ├── nas/                   # ZFS, Samba, NFS, Kopia
│   ├── cache_server/          # Nginx cache server
│   ├── gpu_amd/               # AMD GPU drivers
│   ├── gpu_nvidia/            # NVIDIA GPU drivers
│   ├── gpu_intel/             # Intel GPU drivers
│   ├── monitoring/            # Netdata, sensors
│   └── htpc/                  # Kodi HTPC setup
└── playbooks/
    ├── site.yml               # Main playbook
    ├── bootstrap.yml          # Initial setup
    ├── desktops.yml           # Desktop configuration
    ├── servers.yml            # Server configuration
    └── test.yml               # Testing playbook
```

## Roles Overview

### Common Role

Applied to all machines:
- System configuration (locale, timezone, repositories)
- User management (creates main user, SSH keys)
- **SSH hardening** (via [DevSec SSH Hardening](https://github.com/dev-sec/ansible-ssh-hardening))
  - Strong ciphers and algorithms
  - Key-based authentication only
  - Root login disabled
  - Industry security compliance (CIS, BSI)
- Common CLI tools (bat, ripgrep, fzf, etc.)
- Zsh with oh-my-zsh and Starship prompt
- Tailscale VPN
- UFW firewall
- Fail2ban (SSH brute force protection)

See [SSH Hardening Documentation](docs/SSH_HARDENING.md) for details.

### Desktop Role

Applied to desktop/laptop machines:
- GNOME desktop environment
- GDM display manager with Wayland
- PipeWire audio
- CUPS printing
- Bluetooth
- Fingerprint reader support (optional)
- Desktop applications (Firefox, Chrome, LibreOffice, VS Code, 1Password, etc.)
- Fonts (Fira Code, Nerd Fonts)
- Plymouth boot splash

### Development Environment Role

- Compilers: GCC, Clang, LLVM
- Languages: Go 1.23, Python 3.13, Ruby 3.4, Java (Zulu 24), Node.js 24, Perl
- Virtualization: QEMU/KVM, virt-manager, Docker
- PostgreSQL database
- Tools: Terraform, go-task, act, LunarVim

### Gaming Role

- Steam (with 32-bit libraries)
- Heroic Games Launcher (Flatpak)
- UFW rules for Steam Remote Play

### Server Role

- systemd-networkd configuration
- Server-specific packages

### NAS Role

- ZFS filesystem management
- Samba file sharing
- NFS server
- Avahi (mDNS) for service discovery
- Kopia backup (daily snapshots)

### Cache Server Role

- Nginx web server
- Let's Encrypt SSL certificates (Certbot)
- Generic caching configuration

### GPU Roles

- **gpu_amd**: Mesa/AMDVLK drivers, Vulkan support
- **gpu_nvidia**: Proprietary NVIDIA drivers from graphics-drivers PPA
- **gpu_intel**: Intel VA-API drivers

### Monitoring Role

- Netdata real-time monitoring
- Hardware sensor modules (e.g., nct6775 for motherboard sensors)

### HTPC Role

- Kodi media center
- Auto-login configuration (optional)

## Common Tasks

### Update SSH Keys

```bash
# Update the SSH keys URL in inventory/group_vars/all.yml
# Then run:
ansible-playbook playbooks/site.yml --tags users
```

### Add a New Package

Edit the appropriate variable file:
- Common packages: `inventory/group_vars/all.yml` → `common_packages`
- Desktop packages: `inventory/group_vars/desktops.yml` → `desktop_packages`

Then run:
```bash
ansible-playbook playbooks/site.yml --tags packages
```

### Reconfigure Firewall

Edit firewall rules in `inventory/group_vars/all.yml` or host-specific files, then:

```bash
ansible-playbook playbooks/site.yml --tags common
```

### Update GNOME Extensions

GNOME extensions must be installed manually via the GNOME Extensions app or browser. The role will remind you of recommended extensions.

### Backup Configuration

The NAS role configures Kopia for daily backups. To manually trigger:

```bash
ansible nas_servers -m shell -a "systemctl start kopia-snapshot.service" --become
```

### Check ZFS Pool Status

```bash
ansible nas_servers -m shell -a "zpool status" --become
```

## Secrets Management

### Ansible Vault

For sensitive data, use Ansible Vault:

```bash
# Create encrypted file
ansible-vault create inventory/group_vars/vault.yml

# Edit encrypted file
ansible-vault edit inventory/group_vars/vault.yml

# Run playbook with vault
ansible-playbook playbooks/site.yml --ask-vault-pass
```

Example vault content:
```yaml
vault_tailscale_authkey: "tskey-auth-xxxxx"
vault_samba_password: "secure_password"
```

### Environment Variables

Set sensitive variables via environment:

```bash
export TAILSCALE_AUTHKEY="tskey-auth-xxxxx"
ansible-playbook playbooks/site.yml
```

## Troubleshooting

### SSH Connection Issues

```bash
# Verbose SSH debugging
ansible all -m ping -vvv

# Use password authentication
ansible all -m ping --ask-pass

# Specify SSH user
ansible all -m ping -u username
```

### Privilege Escalation Issues

```bash
# Ask for sudo password
ansible-playbook playbooks/site.yml --ask-become-pass
```

### Check Syntax

```bash
ansible-playbook playbooks/site.yml --syntax-check
```

### Dry Run

```bash
ansible-playbook playbooks/site.yml --check
```

### Role-Specific Issues

#### NVIDIA Driver Not Loading

```bash
# Check if nouveau is blacklisted
ansible nvidia_gpu -m shell -a "lsmod | grep nouveau" --become

# Update initramfs manually
ansible nvidia_gpu -m shell -a "update-initramfs -u" --become

# Reboot
ansible nvidia_gpu -m reboot --become
```

#### ZFS Pool Not Importing

```bash
# Check available pools
ansible nas_servers -m shell -a "zpool import" --become

# Manually import
ansible nas_servers -m shell -a "zpool import dpool" --become
```

#### Tailscale Not Connecting

```bash
# Check Tailscale status
ansible all -m shell -a "tailscale status" --become

# Re-authenticate
ansible all -m shell -a "tailscale up --authkey=<key>" --become
```

## Migration from NixOS

### Pre-Migration Checklist

1. ✅ Backup all data
2. ✅ Export ZFS snapshots (NAS)
3. ✅ Document current configurations
4. ✅ Save user data and dotfiles
5. ✅ Note current package versions
6. ✅ Export Tailscale auth key

### Migration Order

Recommended order to minimize downtime:

1. **esbcn1-nix-cache1** (lowest risk, VM)
2. **carbuncle** (HTPC, non-critical)
3. **garuda** (laptop)
4. **bahamut** (workstation)
5. **esbcn1-nas1** (NAS, save for last)

### Per-Host Migration Steps

1. Fresh Ubuntu 24.04 installation
2. Run bootstrap playbook
3. Run site playbook
4. Verify functionality
5. Restore user data
6. Monitor for 48 hours

### Known Differences

- No atomic rollbacks (unlike NixOS)
- Package versions may differ
- GNOME extensions require manual installation
- Development environment won't match Nix precision
- System is more mutable

## Maintenance

### Regular Updates

```bash
# Update packages on all machines
ansible all -m apt -a "upgrade=dist update_cache=yes" --become

# Reboot if required
ansible all -m reboot --become -a "test_command=uptime"
```

### Update Ansible Roles

```bash
ansible-galaxy install -r requirements.yml --force
```

### Check for Security Updates

```bash
ansible all -m shell -a "apt list --upgradable" --become
```

## Contributing

When adding new roles or modifying existing ones:

1. Test in a VM first
2. Use tags appropriately
3. Document variables in role README
4. Update this main README
5. Follow Ansible best practices

## License

MIT

## Support

For issues or questions:
- Check the troubleshooting section
- Review role-specific documentation
- Open an issue in the repository

---

**Note**: This configuration is derived from a NixOS setup. Some features may require manual configuration or adjustments based on your specific needs.
