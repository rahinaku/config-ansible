# Development Environment Setup

Ansible playbook for development tools installation.

## Tools

- Neovim
- Lazygit
- Zellij
- Zsh (with oh-my-zsh)

## Requirements

- Ubuntu/Debian Linux
- Ansible 2.9+

## Usage

### Install all tools

```bash
ansible-playbook -i hosts site.yml
```

### Install specific tool

```bash
ansible-playbook -i hosts site.yml --tags lazygit
ansible-playbook -i hosts site.yml --tags neovim
ansible-playbook -i hosts site.yml --tags zellij
ansible-playbook -i hosts site.yml --tags zsh
```

## Installation Paths

- Binaries: `~/.local/bin/`
- Config: `~/.config/<tool>/`
- Data: `~/.local/share/<tool>/`

## Update Versions

Edit `roles/<tool>/vars/main.yml` to change versions.
