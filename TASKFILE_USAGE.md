# Taskfile Usage Guide

This project uses [Task](https://taskfile.dev) for task automation instead of Makefiles.

## Installation

If you don't have Task installed:

```bash
# Linux/macOS
sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin

# Or via package manager
# Ubuntu/Debian
sudo snap install task --classic

# macOS
brew install go-task

# Arch
sudo pacman -S go-task
```

## Quick Reference

### Basic Commands

```bash
# List all available tasks
task --list

# Show detailed help
task help

# Install Ansible Galaxy dependencies
task install

# Test connectivity
task ping

# Deploy to all hosts
task deploy
```

### Deployment Tasks

```bash
# Deploy to all hosts
task deploy

# Deploy to desktops only
task deploy:desktops

# Deploy to servers only
task deploy:servers

# Deploy to specific host
task deploy:host HOST=garuda

# Dry run (check what would change)
task deploy:check

# Deploy with specific tags
task deploy:tags TAGS=common,desktop
```

### Bootstrap and Setup

```bash
# Bootstrap fresh Ubuntu installations
task bootstrap

# Set up development environment
task dev:setup

# Run full test suite
task dev:test
```

### Role-Specific Deployments

```bash
# Deploy only common role
task common

# Deploy only desktop environment
task desktop

# Deploy only development tools
task devenv

# Deploy only gaming software
task gaming

# Deploy only GPU drivers
task gpu

# Deploy only NAS configuration
task nas

# Deploy only monitoring stack
task monitoring
```

### Maintenance Tasks

```bash
# Update all packages on all hosts
task update:packages

# Update Ansible Galaxy roles
task update:roles

# Clean temporary files
task clean

# Reboot specific host
task reboot HOST=garuda
```

### Validation Tasks

```bash
# Check playbook syntax
task check

# Lint Ansible files
task lint

# Validate configuration (for CI/CD)
task ci:validate
```

### Information Tasks

```bash
# List all hosts
task list:hosts

# List all available tags
task list:tags

# List all tasks in playbooks
task list:tasks

# Gather facts for specific host
task facts HOST=garuda
```

### Vault Management

```bash
# Create encrypted vault file
task vault:create

# Edit encrypted vault file
task vault:edit

# View encrypted vault file
task vault:view
```

### Ad-hoc Commands

```bash
# Run shell command on hosts
task shell HOST=all CMD="uptime"

# Reboot specific host or group
task reboot HOST=desktops
```

## Task Structure

The Taskfile is located at `Taskfile.ansible.yml` and includes:

- **Deployment tasks**: Deploy configurations
- **Role-specific tasks**: Deploy individual roles
- **Maintenance tasks**: Updates, cleanup
- **Validation tasks**: Syntax checking, linting
- **Information tasks**: List hosts, tags, tasks
- **Vault tasks**: Manage encrypted secrets
- **Utility tasks**: Ad-hoc commands, reboots

## Common Workflows

### Initial Setup

```bash
task install          # Install dependencies
task ping             # Test connectivity
task bootstrap        # Bootstrap Ubuntu
task deploy           # Deploy configuration
```

### Updating a Single Host

```bash
task deploy:host HOST=garuda
```

### Deploying Just Gaming Software

```bash
task gaming
```

### Full System Update

```bash
task update:packages  # Update all packages
task deploy           # Redeploy configuration
task reboot HOST=all  # Reboot if needed
```

### Testing Changes

```bash
task check            # Check syntax
task lint             # Lint playbooks
task deploy:check     # Dry run
```

## Advantages Over Makefile

1. **Better syntax**: YAML instead of Makefile syntax
2. **Cross-platform**: Works consistently on all platforms
3. **Variables**: Better variable handling
4. **Dependencies**: Clearer task dependencies
5. **Integration**: Integrates with existing Taskfile.yml
6. **Modern**: Active development and community

## Environment Variables

You can set variables via environment or inline:

```bash
# Inline variable
task deploy:host HOST=garuda

# Environment variable
export HOST=garuda
task deploy:host

# Multiple variables
task deploy:tags TAGS=common,desktop
```

## Tips

- Use `task --list` to see all available tasks
- Use `task --summary <task-name>` for task details
- Tasks support tab completion (if configured)
- You can run multiple tasks: `task install ping deploy`

## Integration with Main Taskfile

If you have a main `Taskfile.yml` in the root, you can include this:

```yaml
# In main Taskfile.yml
includes:
  ansible: Taskfile.ansible.yml

# Then use:
# task ansible:deploy
# task ansible:ping
```

## Documentation

- Main docs: [ANSIBLE_README.md](ANSIBLE_README.md)
- Quick start: [QUICKSTART.md](QUICKSTART.md)
- Task homepage: https://taskfile.dev
