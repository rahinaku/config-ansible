# Development Environment Setup

Ansible playbook for development tools installation.

## Tools

- Neovim
- Lazygit
- Zellij
- Zsh (with oh-my-zsh)
- Mise

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
ansible-playbook -i hosts site.yml --tags mise
```

## Installation Paths

- Binaries: `~/.local/bin/`
- Config: `~/.config/<tool>/`
- Data: `~/.local/share/<tool>/`

## Update Versions

Edit `roles/<tool>/vars/main.yml` to change versions.

## Windows特有の設定

### WinRMの有効化
powershellを管理者権限で起動し、以下のようにスクリプトを実行する
```
powershell.exe -ExecutionPolicy ByPass -File site-windows.ps1
```

winRMが起動しているかを以下のコマンドで確認

```shell
Get-Service WinRM
```

winrmを起動
```shell
Start-Service WinRM
```

いかのコマンドで起動しているかを確認

```shell
Status   Name               DisplayName
------   ----               -----------
Running  WinRM              Windows Remote Management (WS-Manag...
```

以下のコマンドで疎通確認
```
Test-WSMan -ComputerName localhost
```

``` 
wsmid           : http://schemas.dmtf.org/wbem/wsman/identity/1/wsmanidentity. xsd
ProtocolVersion : http://schemas.dmtf.org/wbem/wsman/1/wsman.xsd
ProductVendor   : Microsoft Corporation
ProductVersion  : OS:  0.0.0 SP: 0.0 Stack: 3.0
```

### Basic認証と非暗号化通信の有効化

Ansibleから接続するために、Basic認証と非暗号化通信を有効化します。

#### 1. ネットワークプロファイルの確認と変更

```powershell
# 現在のネットワークプロファイルを確認
Get-NetConnectionProfile

# PublicからPrivateに変更（Publicの場合はWinRM設定変更不可）
Set-NetConnectionProfile -NetworkCategory Private
```

#### 2. Basic認証と非暗号化通信の状態確認

```powershell
# Basic認証の状態を確認
Get-Item WSMan:\localhost\Service\Auth\Basic

# 非暗号化通信の状態を確認
Get-Item WSMan:\localhost\Service\AllowUnencrypted
```

期待される出力: `Value = True`

#### 3. Basic認証と非暗号化通信の有効化

```powershell
# Basic認証を有効化
Set-Item WSMan:\localhost\Service\Auth\Basic -Value $true

# 非暗号化通信を許可
Set-Item WSMan:\localhost\Service\AllowUnencrypted -Value $true
```

### WSLからwindowsホストに対して実施する場合は以下も設定

WSLネットワークからWinRMへのアクセスを許可する
```powershell
New-NetFirewallRule -DisplayName "WinRM HTTP for WSL" `
    -Direction Inbound `
    -LocalPort 5985 `
    -Protocol TCP `
    -Action Allow `
    -RemoteAddress 172.16.0.0/12
```

### ホストのIPアドレスを取得

```shell
ip route | grep 'default via' | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'
```
