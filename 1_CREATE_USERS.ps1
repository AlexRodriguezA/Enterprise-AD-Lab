# ----- Edit these Variables for your own Use Case ----- #
$PASSWORD_FOR_USERS = "Password1"
$OU_NAME            = "_EMPLOYEES"
$NAMES_FILE         = Join-Path $PSScriptRoot "names.txt"
# ------------------------------------------------------ #

# Make sure AD module is available
Import-Module ActiveDirectory -ErrorAction Stop

# Read the names file (FirstName LastName per line)
if (-not (Test-Path $NAMES_FILE)) {
    Write-Error "names.txt not found. Expected at: $NAMES_FILE"
    exit 1
}
$USER_FIRST_LAST_LIST = Get-Content $NAMES_FILE

# Convert the plain text password to a secure string
$password = ConvertTo-SecureString $PASSWORD_FOR_USERS -AsPlainText -Force

# Create OU to hold the users (ignore error if it already exists)
$newOuParams = @{
    Name                          = $OU_NAME
    ProtectedFromAccidentalDeletion = $false
    ErrorAction                   = 'SilentlyContinue'
}
New-ADOrganizationalUnit @newOuParams

# Build DN path for the OU we just created
$domainDn = ([ADSI]"").distinguishedName
$ouPath   = "OU=$OU_NAME,$domainDn"

foreach ($n in $USER_FIRST_LAST_LIST) {

    # Skip blank lines
    if ([string]::IsNullOrWhiteSpace($n)) { continue }

    # Split "First Last" and normalize
    $parts = $n.Trim() -split "\s+"
    $first = $parts[0].ToLower()
    $last  = $parts[1].ToLower()

    # Username: first initial + last name (e.g. jdoe)
    $username = ("{0}{1}" -f $first.Substring(0,1), $last).ToLower()

    Write-Host "Creating user: $username" -BackgroundColor Black -ForegroundColor Blue

    New-ADUser -AccountPassword      $password `
               -GivenName            $first `
               -Surname              $last `
               -DisplayName          $username `
               -Name                 $username `
               -SamAccountName       $username `
               -UserPrincipalName    "$username@$((Get-ADDomain).DNSRoot)" `
               -EmployeeID           $username `
               -PasswordNeverExpires $true `
               -Path                 $ouPath `
               -Enabled              $true
}
