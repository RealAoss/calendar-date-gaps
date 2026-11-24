[CmdletBinding()]
param(
    [Parameter(Mandatory, Position=0)][string]$InputFile,
    [string]$OutputFile
)
$ErrorActionPreference = 'Stop'
$culture = [Globalization.CultureInfo]::InvariantCulture
try {
    $records = @(Get-Content -LiteralPath $InputFile -Encoding utf8 | ForEach-Object { $_.Trim() } | Where-Object { $_ })
    if (-not $records.Count) { throw 'The input file is empty.' }
    $result = @(& {
        $dates = @($records | ForEach-Object {
            [DateTime]::ParseExact($_, 'yyyy-MM-dd', $culture)
        } | Sort-Object -Unique)
        if ($dates.Count -lt 2) { throw 'Enter at least two distinct dates.' }
        for ($i = 1; $i -lt $dates.Count; $i++) {
            '{0:yyyy-MM-dd} → {1:yyyy-MM-dd} · {2} days' -f $dates[$i-1], $dates[$i], ($dates[$i]-$dates[$i-1]).Days
        }
    })
    if ($OutputFile) {
        $stream = [IO.File]::Open([IO.Path]::GetFullPath($OutputFile), 'CreateNew', 'Write')
        try {
            $bytes = [Text.Encoding]::UTF8.GetBytes(($result -join [Environment]::NewLine) + [Environment]::NewLine)
            $stream.Write($bytes, 0, $bytes.Length)
        } finally { $stream.Dispose() }
    } else { $result }
} catch {
    [Console]::Error.WriteLine($_.Exception.Message)
    exit 1
}
