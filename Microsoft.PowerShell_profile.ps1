# 使用utf8编码
$OutputEncoding = [console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

oh-my-posh init pwsh --config C:\Users\Fighoh\Tools\themes\kushal.omp.json | Invoke-Expression

function et {exit}

Set-TerminalIconsTheme #terminalIcon 安装Install-Module -Name Terminal-Icons -Repository PSGallery 导入 Import-Module -Name Terminal-Icons

function set_proxy_variable {
	Set-Item Env:http_proxy "http://127.0.0.1:7890"  # 代理地址
	Set-Item Env:https_proxy "http://127.0.0.1:7890" # 代理地址
}

function unset_proxy_variable {
    Remove-Item Env:http_proxy
    Remove-Item Env:https_proxy
}

New-Alias -Name pro -Value set_proxy_variable
New-Alias -Name upro -Value unset_proxy_variable

# powershell初始化加载 PSReadLine 模块
Import-Module PSReadLine

# 使用历史记录进行脚本提示
Set-PSReadLineOption -PredictionSource History

# alt在windows中有特殊用途，这里使用ctrl键代替
Set-PSReadLineKeyHandler -Chord "Ctrl+RightArrow" -Function ForwardWord

# 删除默认的连接（强制删除）
Remove-Alias ls -Force
Remove-Alias sl -Force

function ls {Get-ChildItem | Format-Wide}
function lsall {Get-ChildItem}
function cj {cd ..}
function cl {clear}


