<#  BitTitan Take Home Assignment
    Name: Dion Toh Siyong   #> 

$ErrorActionPreference = 'stop'

do { 
    Write-Host "(1) Create Local User`n(2) Rename Local User`n(3) Remove Local User`n(4) Terminate Program"         # Main menu to navigate
    $userInputMain = Read-Host "`nEnter your choice"
    switch ($userInputMain) {
        1 {
            # Create new account
            do {
                $invalid = 1
                $accountName = Read-Host "`nUsername"; # Get the name of the new account
                if ($accountName.Length -gt 20) {       # Checks length of username 
                    Write-Host "`nUsername is too long. Please ensure that it is less that 20 characters.`n"
                }
            } while ($accountName.Length -gt 20)
            $userInput = Read-Host "`nCreate a Password for the account?`nYes[Y] No[N]"       # Gives user the option to decide if password is required for the account
            switch ($userInput) {
                Y {}
                y {
                    $Password = Read-Host "`nPassword" -AsSecureString; # Gets password from user
                    try {
                        New-LocalUser -Name $accountName -Password $Password -Confirm;
                        Write-Host "`nSuccessfully created!"
                        break;
                    }
                    catch [Microsoft.PowerShell.Commands.AccessDeniedException] {
                        # If Powershell not ran as administrator
                        Write-Host "`nAn Error has occurred`nPlease run the application as an administrator"
                    }
                    catch [Microsoft.PowerShell.Commands.InvalidNameException] {
                        # Invalid username
                        Write-Host "`nInvalid name`nUsername cannot include the following characters:
                        `", /, \, [, ], :, ;, |, =, ,, +, *, ?, <, >, @"
                    }
                }
                N {}
                n {
                    try {
                        # No Password
                        New-LocalUser -Name $accountName -NoPassword -Confirm;
                        Write-Host "Successfully created!"
                        break;
                    }
                    catch [Microsoft.PowerShell.Commands.AccessDeniedException] {
                        # If Powershell not ran as administrator
                        Write-Host "`nAn Error has occurred`nPlease run the application as an administrator"
                    }
                    catch [Microsoft.PowerShell.Commands.InvalidNameException] {
                        # Invalid username
                        Write-Host "`nInvalid username`nUsername cannot include the following characters:
                        `", /, \, [, ], :, ;, |, =, ,, +, *, ?, <, >, @"
                    }
                }
                Default { Write-Host "`nInvalid Input!`n" }     # User did not input y or n
            }
        }
        2 {
            # Rename local account
            $oldName = Read-Host "`nWhich account do you wish to rename"      # Gets the name of the account to be changed
            do {
                $newName = Read-Host "`nWhat do you wish to rename it to"         # Gets the new name of the account
                if ($newName.Length -gt 20) {       # Checks length of username 
                    Write-Host "`nUsername is too long. Please ensure that it is less that 20 characters.`n"
                }
            } while ($newName.Length -gt 20)
            try {
                Rename-LocalUser -Name $oldName -NewName $newName -Confirm
                Write-Host "`nSuccessfully renamed!"
                Break
            }
            catch [Microsoft.PowerShell.Commands.AccessDeniedException] {
                # If Powershell not ran as administrator
                Write-Host "`nAn Error has occurred`nPlease run the application as an administrator"
            }
            catch [Microsoft.PowerShell.Commands.UserNotFoundException] {
                # Original account was not found
                Write-Host "`nAn Error has occurred`nAccount was not found`n"
            }
            catch [Microsoft.PowerShell.Commands.InvalidNameException] {
                # Invalid username
                Write-Host "`nInvalid name`nUsername cannot include the following characters:
                `", /, \, [, ], :, ;, |, =, ,, +, *, ?, <, >, @"
            }
        }
        3 {
            # Removes local user
            $userInput = Read-Host "`nWhich account do you wish to remove"    # Gets name of account to be removed
            try {
                Remove-LocalUser -Name $userInput -Confirm
                Write-Host "`nSuccessfully removed!"
                Break
            }
            catch [Microsoft.PowerShell.Commands.AccessDeniedException] {
                # If Powershell not ran as administrator
                Write-Host "`nAn Error has occurred`nPlease run the application as an administrator`n"
            }
            catch [Microsoft.PowerShell.Commands.UserNotFoundException] {
                # Account was not found
                Write-Host "`nAn Error has occurred`nAccount was not found`n"
            }
        }
        4 { Write-Host "`nTerminating....`n"; Exit }
        Default { Write-Host "`nInvalid Option"; Break }
    }

} while ($userInputMain -ne 4)