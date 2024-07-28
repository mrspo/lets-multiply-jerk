# Title
Write-Host "Let's multiply, jerk" -ForegroundColor DarkGreen
Start-Sleep -Seconds 2

$multiplicandRange = @(1..12)
$multiplierRange = @(1..12)
$response = $null
$multiplier = $null
$multiplicand = $null
$colors = [enum]::GetValues([System.ConsoleColor]) | Where-Object {$_ -ne "Black" -and $_ -ne "DarkGray" -and $_ -ne "White" -and $_ -ne "Gray"}

try {
    $insults = Get-Content .\insults.txt
    $compliments = Get-Content .\compliments.txt
}
catch {
    Write-Output $_
    break
}

# Pre-start prompt
Write-Host "Are you ready? If you say no, I will insult you and the program will close in 5 seconds." -ForegroundColor Blue
$response = Read-Host 
while($response -ne "yes" -and $response -ne "y" -and $response -ne "si" -and $response -ne "no" -and $response -ne "n")
{
    Write-Host "Are you ready? Only yes, no, and si are accepted" -ForegroundColor Yellow
    $response = Read-Host 
}

if($response -eq "y" -or $response -eq "yes" -or $response -eq "si")
{
    Write-Host "Good answer! Let's rock this shit!" -ForegroundColor Magenta
    Start-Sleep -Seconds 2
}

elseif($response -eq "n" -or $response -eq "no")
{
    Write-Host "$(Get-Random $insults)" -ForegroundColor (Get-Random $colors)
    Start-Sleep -Seconds 5
    break
}

# Prompt for instructions
Write-Host "Do you want the instructions?" -ForegroundColor Blue
$response = Read-Host 
while($response -ne "yes" -and $response -ne "y" -and $response -ne "si" -and $response -ne "no" -and $response -ne "n")
{
    Write-Host "Do you want the instructions? Only yes, no, and si are accepted" -ForegroundColor Yellow
    $response = Read-Host 
}

if($response -eq "y" -or $response -eq "yes" -or $response -eq "si")
{
    ""
    Write-Host "# When you are presented a problem, please type the answer and hit Enter." -ForegroundColor DarkBlue
    Write-Host "# If correct, you will be given a new problem."  -ForegroundColor DarkBlue
    Write-Host "# If incorrect, you'll be given the same problem again until you enter a correct answer." -ForegroundColor DarkBlue
    ""
    Write-Host "# To quit, answer any problem with 'QUIT'. You'll probably be insulted tho." -ForegroundColor DarkBlue
    ""
    ""
    Start-Sleep -Seconds 5
}
else
{
    Write-Host "Well alright then" -ForegroundColor Blue
    Start-Sleep -Seconds 2
}

# Start the game
do
{
    $a = 0
    $response = $null
    $multiplicand = Get-Random $multiplicandRange
    $multiplier = Get-Random $multiplierRange
    $problem = "$($multiplicand) x $($multiplier) = __"
    $answer = $multiplicand * $multiplier
    Write-Host "Please answer the following question: $($problem)" -ForegroundColor (Get-Random $colors)
    $response = Read-Host 
    if($response -notmatch $answer -and $response -ne 'quit' -and $response -ne 'exit' -and $response -ne 'stop')
    {
        while($response -notmatch $answer -and $response -ne 'quit' -and $response -ne 'exit' -and $response -ne 'stop')
        {
            Write-Host "I'm sorry, that answer is incorrect. Please answer the following question: $($problem)" -ForegroundColor (Get-Random $colors)
            $response = Read-Host 
        }
    }

    if($response -match $answer)
    {
        Write-Host "Excellent! $(Get-Random $compliments)" -ForegroundColor (Get-Random $colors)
        Start-Sleep -Seconds 1
        $a += 1
    }
    
    elseif($response -eq 'quit' -or $response -eq 'exit' -or $response -eq 'stop')
    {
        Write-Host "Okay, let's just quit everything we start, QUITTER :eyeroll:" -ForegroundColor Red
        Write-Host "$(Get-Random $insults)" -ForegroundColor (Get-Random $colors)
        Start-Sleep 6
        break
    }
    
    else
    {
        Write-Host "Something happened. You probably broke it." -ForegroundColor DarkRed
        break
    }
} until ($a -ne 1)