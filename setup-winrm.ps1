# PowerShellを管理者権限で開いて実行

# スクリプトをダウンロード
$url = "https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible. ps1"
$file = "$env:temp\ConfigureRemotingForAnsible.ps1"

# ダウンロード実行
Invoke-WebRequest -Uri $url -OutFile $file

# スクリプトを実行
powershell.exe -ExecutionPolicy ByPass -File $file


