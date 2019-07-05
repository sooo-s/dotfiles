function Set-MyPSReadLineColor(){
  Set-PSReadLineOption -Colors @{
    "Operator" = [ConsoleColor]::DarkYellow
    "Parameter" = [ConsoleColor]::DarkYellow
  }
}

Set-MyPSReadLineColor

function Export-UTF8-Csv($name='./csv.csv'){
  $input | Export-Csv -encoding UTF8 $name
}

function Enter-ExchangeOnline() {
    $global:Cred = Get-Credential
    $global:Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $global:Cred -Authentication Basic -AllowRedirection
    Import-PSSession $global:Session -DisableNameChecking
}

function Exit-ExchangeOnline() {
  Remove-PSSession $global:Session
  exit
}
