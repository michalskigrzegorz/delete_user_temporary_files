### Script who delete temporary files on user profile and delete content on Windows/temp directory
### Grzegorz Michalski - INVERT8
### grzegorz.michalski@invert8.com

# --- USERS --- #

# define start path for user profile, for example:
$pathStart = 'C:\Users\'
# define end path for user profile:
$pathEnd = 'AppData\Local\Temp'
# define path for control files:
# this is important because this is next step to more secure for this operation
# script check if control files is exist on the user profile, if it's true script is executing
$pathHelperChecker = 'AppData\Local\valid_checker.dat'

# define table with name of users
$list = (
    'User1', 
    'User2',
    'User3',
    'User4',
    'User5'
    )

foreach ($Data in $list)
    {
    # save user from table $list to the variable $User
    $User = $Data

    # path helper who is intended for testing the presence of a control file
    $pathValidChecker = "$path_start\$User\$pathHelperChecker"

    # test who check if control file exists
    $checkExistFile = Test-Path $pathValidChecker

    # check contition = if control file exist on defined localization then script removes content on user temp folder, but if control file doesn't exist script skip to the next step
    if ($checkExistFile -eq $True) {

        # define variable $sourcePathUser, path to the user directory
        $sourcePathUser = "$pathStart\$User\$pathEnd"

        # get path from variable $sourcePathUser and delete directory content - Users\...\...\...\Temp    
        Get-ChildItem $sourcePathUser -Force |
            #Remove-Item -Recurse -ErrorAction Ignore
            Remove-Item -Recurse -Force
        }

     else {
        # alert - control file doesn't exist
        write-host "Error, control file doesn't exist"
     }
}

# --- WINDOWS --- #

# define start path
$sourcePathSystem = "C:\Windows\Temp"

# get path form variable $sourcePathSystem and delete content on directory - Windows\Temp    
Get-ChildItem $sourcePathSystem -Force |
    Remove-Item -Recurse -Force
    
