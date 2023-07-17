# 使用utf8编码
$OutputEncoding = [console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

oh-my-posh init pwsh --config C:\Users\Fighoh\Tools\themes\kushal.omp.json | Invoke-Expression

function et {exit}


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

function Color-List($str) {
    $regex_opts = ([System.Text.RegularExpressions.RegexOptions]::IgnoreCase-bor [System.Text.RegularExpressions.RegexOptions]::Compiled)
    $fore = $Host.UI.RawUI.ForegroundColor
    $compressed = New-Object System.Text.RegularExpressions.Regex('\.(zip|tar|gz|rar|jar|war|7z)$', $regex_opts)
    $executable = New-Object System.Text.RegularExpressions.Regex('\.(exe|bat|cmd|py|ps1|psm1|vbs|rb|reg|sh|zsh)$', $regex_opts)
    $code_files = New-Object System.Text.RegularExpressions.Regex('\.(ini|csv|log|xml|yml|json|java|c|cpp|css|sass|js|ts|jsx|tsx|vue|cpp|py)$', $regex_opts)
    $head_files = New-Object System.Text.RegularExpressions.Regex('\.(h)$', $regex_opts)
    $itemList = @()
    Invoke-Expression ("Get-ChildItem" + " " + $str) | ForEach-Object {
        $item = New-Object object
        if ($_.GetType().Name -eq 'DirectoryInfo') 
        {
            $item | Add-Member NoteProperty name ("`e[34m" + $_.name) # 目录名称蓝色
        }
        elseif ($compressed.IsMatch($_.Name)) 
        {
            $item | Add-Member NoteProperty name ("`e[31m" + $_.name) # 压缩文件红色
        }
        elseif ($executable.IsMatch($_.Name))
        {
            $item | Add-Member NoteProperty name ("`e[36m" + $_.name) # 可执行文件青色
        }
        elseif ($code_files.IsMatch($_.Name))
        {
            $item | Add-Member NoteProperty name ("`e[33m" + $_.name) # 代码文件黄色
        }
        elseif ($head_files.IsMatch($_.Name))
        {
            $item | Add-Member NoteProperty name ("`e[32m" + $_.name) # 头文件绿色
        }
        else
        {
            $item | Add-Member NoteProperty name ("`e[37m" + $_.name) # 其他文件默认白色
        } 
        $itemList += $item
    }
    echo $itemList | Format-Wide -AutoSize # 格式化输出
}
function ls {Color-List "-Exclude .*"}
function la {Color-List "$args"}
function cj {cd ..}
function cl {clear}

