# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Ansible playbook for configuring development environments across Linux, macOS, and Windows. Manages installation of CLI tools (neovim, zsh, zellij, lazygit, mise, k9s, etc.) and their configurations.

**Requirements:** Ubuntu/Debian Linux, Ansible 2.9+

## Commands

```bash
# Run main Linux playbook
ansible-playbook -i hosts site.yml

# Run against specific host group
ansible-playbook -i hosts site.yml -l local

# Run specific tool only
ansible-playbook -i hosts site.yml --tags lazygit

# Run Windows playbook
ansible-playbook -i hosts site-windows.yml

# Check system facts
ansible-playbook -i hosts show-facts.yml
```

## Architecture

### Role Structure

Roles are split by platform in `roles/`:
- `roles/linux/` - Linux/macOS roles (neovim, zsh, zellij, lazygit, mise, k9s, etc.)
- `roles/windows/` - Windows roles using Chocolatey (git, alacritty, obsidian)

Each role follows:
```
role-name/
├── tasks/main.yml    # Task definitions
├── vars/main.yml     # Version numbers and URLs
└── files/            # Config files to deploy
```

### Key Variables (defined in site.yml)

Playbooks use XDG Base Directory variables with environment fallbacks:
- `xdg_config_home` → `~/.config`
- `xdg_data_home` → `~/.local/share`
- `xdg_bin_home` → `~/.local/bin`
- `tmp_dir` → `~/ansible-tmp` (temporary downloads)

### Platform Conditionals

Use `ansible_facts['os_family']` for cross-platform tasks:
```yaml
when: ansible_facts['os_family'] == "Debian"   # Linux
when: ansible_facts['os_family'] == "Darwin"   # macOS
```

### Common Patterns

**Binary installation pattern:**
1. Download to `{{ tmp_dir }}` via `get_url`
2. Extract to `{{ xdg_data_home }}/[tool]`
3. Symlink to `{{ xdg_bin_home }}`

**Config deployment:**
- Store configs in `roles/[tool]/files/`
- Deploy to `{{ xdg_config_home }}/[tool]` via `copy` module

**Version management:**
- Edit `roles/<tool>/vars/main.yml` to change versions
- Define: `source_version`, `source_url`, `source_name`

### Inventory Groups

Defined in `hosts`:
- `[local]` - Local execution (connection: local)
- `[home]` - Remote home server
- `[test]` - Docker test container (port 2222)
- `[windows]` - Windows hosts via WinRM (port 5985)

## Windows Setup

Windows requires WinRM enabled with Basic auth and unencrypted communication:

```powershell
# Run setup script as administrator
powershell.exe -ExecutionPolicy ByPass -File setup-winrm.ps1

# For WSL access, add firewall rule
New-NetFirewallRule -DisplayName "WinRM HTTP for WSL" -Direction Inbound -LocalPort 5985 -Protocol TCP -Action Allow -RemoteAddress 172.16.0.0/12
```
