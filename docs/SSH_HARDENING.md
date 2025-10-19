# SSH Hardening Configuration

This project uses the [DevSec SSH Hardening](https://github.com/dev-sec/ansible-ssh-hardening) role for secure SSH configuration.

## Overview

The SSH hardening is automatically applied to all hosts via the `common` role. It provides:

- Strong cryptographic ciphers and algorithms
- Disabled password authentication (SSH keys only)
- Root login disabled
- Protection against brute force attacks
- Secure default configurations based on industry best practices
- Compliance with security benchmarks (CIS, BSI)

## Configuration

SSH settings are configured in `inventory/group_vars/all.yml`:

```yaml
# SSH configuration (used by devsec.hardening.ssh_hardening role)
ssh_port: 22                          # SSH port (default: 22)
ssh_permit_root_login: "no"           # Disable root login
ssh_password_authentication: "no"     # Disable password auth (keys only)
ssh_x11_forwarding: "no"              # Disable X11 forwarding
ssh_max_auth_tries: 3                 # Maximum authentication attempts
ssh_allow_agent_forwarding: true      # Allow agent forwarding (useful for dev)
```

## Features

### ✅ Enabled by Default

- **SSH Key Authentication**: Only public key authentication allowed
- **Strong Ciphers**: Only secure, modern ciphers and algorithms
- **No Root Login**: Root user cannot log in via SSH
- **Client Alive Checks**: Keeps connections alive (300s interval)
- **PAM Integration**: Uses PAM for authentication
- **SFTP Support**: SFTP enabled without chroot
- **Print Last Log**: Shows last login information
- **Failed Login Protection**: Works with fail2ban

### 🔧 Configurable Options

You can customize SSH hardening by setting variables in your inventory:

```yaml
# Custom SSH port
ssh_port: 2222

# Enable X11 forwarding (for specific hosts)
ssh_x11_forwarding: true

# Disable agent forwarding (for servers)
ssh_allow_agent_forwarding: false

# Adjust max authentication attempts
ssh_max_auth_tries: 5
```

## Host-Specific Configuration

### Development Machines (garuda, bahamut)

For development machines, you might want to enable agent forwarding:

```yaml
# host_vars/garuda.yml
ssh_allow_agent_forwarding: true
ssh_x11_forwarding: false  # Still keep X11 disabled for security
```

### Servers (esbcn1-nas1, esbcn1-nix-cache1)

For servers, use stricter settings:

```yaml
# host_vars/esbcn1-nas1.yml
ssh_allow_agent_forwarding: false
ssh_x11_forwarding: false
ssh_max_auth_tries: 2
```

### HTPC (carbuncle)

For HTPC, you might allow local X11 forwarding:

```yaml
# host_vars/carbuncle.yml
ssh_x11_forwarding: true  # For remote GUI apps
ssh_allow_agent_forwarding: false
```

## Security Features

### 1. Strong Ciphers and Algorithms

The role configures SSH to use only secure ciphers:

**Ciphers:**
- chacha20-poly1305@openssh.com
- aes256-gcm@openssh.com
- aes128-gcm@openssh.com
- aes256-ctr
- aes192-ctr
- aes128-ctr

**MACs:**
- hmac-sha2-512-etm@openssh.com
- hmac-sha2-256-etm@openssh.com
- hmac-sha2-512
- hmac-sha2-256

**Key Exchange Algorithms:**
- curve25519-sha256@libssh.org
- diffie-hellman-group-exchange-sha256

### 2. Authentication Security

- Password authentication disabled
- Root login disabled
- Public key authentication required
- Limited authentication attempts (default: 3)
- Challenge-response authentication disabled

### 3. Connection Security

- TCP keep-alive disabled (use SSH keep-alive instead)
- Client alive interval: 300 seconds
- Client alive count max: 3
- Login grace time: 30 seconds

### 4. Additional Security

- Strict mode enabled
- Permission checks on user files
- Host-based authentication disabled
- Empty passwords not permitted
- User environment files ignored

## Integration with Fail2ban

SSH hardening works seamlessly with fail2ban (also configured in the `common` role):

```yaml
fail2ban_enabled: true
fail2ban_maxretry: 10      # Ban after 10 failed attempts
fail2ban_bantime: 3600     # Ban for 1 hour
fail2ban_findtime: 600     # Within 10 minutes
```

Together, they provide:
- Detection of brute force attacks
- Automatic IP banning
- Secure SSH configuration preventing common attacks

## Verification

After deploying, verify your SSH configuration:

```bash
# Check SSH configuration
task shell HOST=garuda CMD="sshd -T"

# Test SSH connection with verbose output
ssh -vv user@host

# Check applied ciphers
ssh -Q cipher

# Check applied MACs
ssh -Q mac

# Check applied key exchange algorithms
ssh -Q kex
```

## Compliance

The SSH hardening role implements recommendations from:

- **CIS Benchmarks**: Center for Internet Security benchmarks
- **BSI**: German Federal Office for Information Security
- **Mozilla Security Guidelines**: Modern security configurations
- **DevSec Hardening Framework**: Industry security baseline

## Troubleshooting

### Cannot Connect After Hardening

1. **Check SSH keys are in place:**
   ```bash
   ansible all -m shell -a "cat ~/.ssh/authorized_keys" -u root --ask-pass
   ```

2. **Verify SSH service is running:**
   ```bash
   task shell HOST=garuda CMD="systemctl status ssh"
   ```

3. **Check firewall allows SSH:**
   ```bash
   task shell HOST=garuda CMD="ufw status | grep 22"
   ```

### Old SSH Client Cannot Connect

If using an older SSH client:

1. Update your client to a modern version
2. Or temporarily relax ciphers (not recommended):
   ```yaml
   # Only for legacy systems
   ssh_hardening_enabled: false
   ```

### Agent Forwarding Not Working

Enable it in host variables:

```yaml
ssh_allow_agent_forwarding: true
```

Then reconnect with:
```bash
ssh -A user@host
```

## Custom Configuration

For advanced customization, you can override any variable from the hardening role:

```yaml
# Full list of options: https://github.com/dev-sec/ansible-ssh-hardening

# Example: Custom cipher list
ssh_ciphers:
  - chacha20-poly1305@openssh.com
  - aes256-gcm@openssh.com

# Example: Custom MACs
ssh_macs:
  - hmac-sha2-512-etm@openssh.com
  - hmac-sha2-256-etm@openssh.com

# Example: Custom KexAlgorithms
ssh_kex:
  - curve25519-sha256@libssh.org
  - diffie-hellman-group-exchange-sha256
```

## References

- [DevSec SSH Hardening Role](https://github.com/dev-sec/ansible-ssh-hardening)
- [Mozilla SSH Security Guidelines](https://infosec.mozilla.org/guidelines/openssh)
- [CIS Ubuntu Benchmark](https://www.cisecurity.org/benchmark/ubuntu_linux)
- [OpenSSH Security Best Practices](https://www.openssh.com/security.html)

## Migration from Manual Configuration

The old manual SSH configuration (`roles/common/tasks/ssh.yml`) has been replaced by the hardening role. The old file is kept as `ssh.yml.old` for reference.

Key differences:
- **Before**: Manual sshd_config edits
- **After**: Comprehensive security baseline from dev-sec
- **Benefit**: Industry-standard security, maintained by security experts

## Next Steps

1. Review SSH settings in `inventory/group_vars/all.yml`
2. Customize per-host if needed in `host_vars/`
3. Deploy: `task deploy`
4. Test SSH connections
5. Verify security with `ssh -vv`
