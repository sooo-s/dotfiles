function Set-MyPSReadLineColor(){
  Set-PSReadLineOption -Colors @{
    "Operator" = [ConsoleColor]::DarkYellow
    "Parameter" = [ConsoleColor]::DarkYellow
  }
}

Set-MyPSReadLineColor
