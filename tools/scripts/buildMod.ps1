$gitmodRoot = $PSScriptRoot + "\..\..\"
$ArmaAddonPath = "E:\Steam\steamapps\common\Arma 3\MODS\"
$ModPath = Join-Path -Path $ArmaAddonPath -childPath "@OPT_Client"

# Prep everything
Remove-Item $ModPath -Recurse
New-Item -Path $ModPath -ItemType Directory
New-Item -Path ($ModPath + "\addons") -ItemType Directory

# Build mod files
Get-ChildItem ($PSScriptRoot + "\..\..\addons\")  -Directory | ForEach-Object { &($PSScriptRoot + "\..\programs\armake2.exe") pack -v "$($_.FullName)" ($ModPath + "\addons\$($_.Name).pbo") }

Copy-Item ($gitmodRoot + "mod.cpp") $ModPath
Copy-Item ($gitmodRoot + "opt4_icon.paa") $ModPath
# Copy-Item ($gitmodRoot + "\addons\*") -Filter *.pbo -Destination ($ModPath + "\addons")
Write-Output "Built and moved to " $ModPath