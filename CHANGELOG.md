# Changelog

All notable changes to this Ansible configuration project.

## [2024-10-19] - SSH Hardening Integration

### Added
- **DevSec SSH Hardening role** integration for industry-standard SSH security
  - Strong cryptographic ciphers and algorithms
  - Compliance with CIS, BSI, and Mozilla security guidelines
  - Automatic configuration of secure SSH defaults
  - Integration with existing fail2ban setup

### Changed
- **SSH Configuration**: Migrated from manual sshd_config edits to devsec.hardening.ssh_hardening role
  - Old configuration preserved in `roles/common/tasks/ssh.yml.old`
  - All SSH settings now controlled via variables in inventory
  - Enhanced security baseline with modern ciphers and algorithms

### Updated
- `requirements.yml`: Added `devsec.hardening` v8.8.0
- `roles/common/meta/main.yml`: Added ssh_hardening role dependency
- `roles/common/tasks/main.yml`: Removed manual SSH configuration
- `inventory/group_vars/all.yml`: Added ssh_allow_agent_forwarding option

### Documentation
- Added `docs/SSH_HARDENING.md` - Comprehensive SSH hardening documentation
- Updated `ANSIBLE_README.md` - Enhanced Common Role description
- Included security features, compliance info, and troubleshooting

### Benefits
- ✅ Industry-standard security baseline
- ✅ Maintained by security experts
- ✅ Regular updates with latest security recommendations
- ✅ Easier to audit and verify compliance
- ✅ Reduced maintenance overhead

---

## [2024-10-19] - Initial Ansible Configuration

### Added
- Complete Ansible infrastructure automation for 5 hosts
- 11 custom roles (common, desktop, devenv, gaming, server, nas, cache_server, gpu_amd, gpu_nvidia, gpu_intel, monitoring)
- Integration with 9 Ansible Galaxy roles
- Taskfile automation (replaced Makefile)
- Comprehensive documentation (README, QUICKSTART, TASKFILE_USAGE)

### Roles
- **common**: Base system, users, SSH, packages, shell, Tailscale, firewall, fail2ban
- **desktop**: GNOME, PipeWire, printing, Bluetooth, applications, fonts
- **devenv**: Compilers, languages (Go, Python, Ruby, Java, Node.js), Docker, QEMU, PostgreSQL
- **gaming**: Steam, Heroic Games Launcher
- **server**: systemd-networkd configuration
- **nas**: ZFS, Samba, NFS, Avahi, Kopia backups
- **cache_server**: Nginx, Let's Encrypt
- **gpu_amd/nvidia/intel**: GPU drivers
- **monitoring**: Netdata, hardware sensors
- **htpc**: Kodi media center

### Infrastructure
- **3 Desktop/Laptop machines**: garuda (Framework 13 AMD), bahamut (workstation), carbuncle (HTPC)
- **2 Server machines**: esbcn1-nas1 (NAS), esbcn1-nix-cache1 (cache server)

### Galaxy Roles Used
- artis3n.tailscale - VPN
- geerlingguy.docker - Container runtime
- geerlingguy.nginx - Web server
- geerlingguy.certbot - SSL certificates
- geerlingguy.postgresql - Database
- bertvv.samba - File sharing
- geerlingguy.nfs - NFS server
- weareinteractive.ufw - Firewall
- robertdebock.fail2ban - Brute force protection

### Features
- Declarative infrastructure as code
- Host-specific and group-based configuration
- Tag-based deployment control
- Secrets management via Ansible Vault
- Automated testing and validation
- CI/CD ready

### Documentation
- ANSIBLE_README.md - Comprehensive guide (400+ lines)
- QUICKSTART.md - Quick reference
- TASKFILE_USAGE.md - Task automation guide
- docs/SSH_HARDENING.md - SSH security documentation

### Migration
- Complete migration guide from NixOS
- Feature parity with existing NixOS configuration
- Preservation of all services and functionality
