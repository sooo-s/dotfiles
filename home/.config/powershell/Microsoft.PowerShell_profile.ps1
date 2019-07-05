function Set-MyPSReadLineColor(){
  Set-PSReadLineOption -Colors @{
    "Operator" = [ConsoleColor]::DarkYellow
    "Parameter" = [ConsoleColor]::DarkYellow
  }
}

Set-MyPSReadLineColor

function Enter-ExchangeOnline() {
    $global:Cred = Get-Credential
    $global:Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $global:Cred -Authentication Basic -AllowRedirection
    Import-PSSession $global:Session -DisableNameChecking
}

function Exit-ExchangeOnline() {
  Remove-PSSession $global:Session
  exit
}
