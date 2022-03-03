if ($args.Count -eq 1){
    $password=$args[0]
}elseif ($args.Count -eq 2 -and $args[0] -eq "-f" ) {
    $password = Get-Content $args[1] 
}

# Function for each requirement
#Length – minimum of 10 characters.
function CheckPasswordLength($pass) {
    if ( $pass.Length -lt 11){
        Write-Host "Password length is less than 10 characters"  -fore red
        return 1
    } else {
        return 0
    }
}


#Check if value Contain digits
function CheckPasswordDigits($pass) {
    if (-NOT ( $pass -match '\d')){
        Write-Host "Password does NOT contain digits"  -fore red
        return 1
    } else {
        return 0
    }
}


#Check if value contain small letters
function CheckPasswordSmallLetters($pass)
 {
    if  (-NOT ($pass -cmatch "[a-z]")){
        Write-Host "Password does NOT contain small letters"  -fore red
        return 1
    } else {
        return 0
    }
 }

 #Check if value contain capital letters
function CheckPasswordCapitalLetters($pass)
{
   if  (-NOT ($pass -cmatch "[A-Z]")){
       Write-Host "Password does NOT contain capital letters"  -fore Red
       return 1
    } else {
        return 0
    }
}

# Password validator: run each test and check the return value.
# If none fails, return OK and exit with 0, else return 1

$ret = $(CheckPasswordLength($password)) + $(CheckPasswordDigits($password)) +$(CheckPasswordSmallLetters($password))     + $(CheckPasswordCapitalLetters($password))

if ($ret -eq 0){
    Write-Host "Your password is valid"  -fore Green
    exit 0    
}else{
    exit 1        
}