$GameRootPath = $null
$SoundPlayerPath = $null
$WindowRendererPath = $null
$SafeToRunGame = 0

##Game Paths as Strings
$LiteralPathString1 = ('$GameRootPath')
$LiteralPathString2 = ('$SoundPlayerPath')
$LiteralPathString3 = ('$WindowRendererPath')
$LiteralVariableString = ('$SafeToRunGame')
#

##DEPENENCIES
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
##


##Hides Console

Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();

[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'

function Hide-Console {

$consolePtr = [Console.Window]::GetConsoleWindow()
    #0 hide
    [Console.Window]::ShowWindow($consolePtr, 0)
}
##

Function Write-StringToFile {
    param (
        [string]$FilePath,
        [string]$String,
        [int]$LineNumber
    )

    # Create the file if it doesn't exist
    If (-not (Test-Path $FilePath)) {
        New-Item -ItemType File -Path $FilePath
    }

    $fileContent = Get-Content -Path $FilePath -Raw
    $newContent = ($fileContent -split "`n")

    Try {
        $newContent[$LineNumber] = $String
    } Catch {
        Write-Warning "Line number is outside the bounds of the array. Continuing with the script."
    }
    Set-Content -Path $FilePath -Value ($newContent -join "`n")
}

Hide-Console
cls

    if ($GameRootPath -eq $null) {
        ##Informs player that game is installing
        [System.Windows.Forms.MessageBox]::Show("Game is installing. Please Wait...")
        #

        ##Figures out where the hell it's at
        $BioSimulator2Path = $MyInvocation.MyCommand.Path

        if ($PSScriptRoot -eq $null) {
            $PSScriptRoot = Split-Path $BioSimulator2Path
            #Write-Host "Script path: $BioSimulator2Path"
        #

        } else {

            #Autosave Game Root Path
            $GameRootPath = $PSScriptRoot
            $filePath = "$GameRootPath\Bio Simulator 2.ps1"
            Write-Output "$filePath"
            $GameRootPath = """$GameRootPath"""
            Write-Output "$GameRootPath"
            $textToAdd = "$LiteralPathString1 = $GameRootPath"
            Write-Output "$textToAdd"
            Write-StringToFile -FilePath $filePath -String $textToAdd -LineNumber 0
            ##

            ##Autosave Sound Player Path
            $GameRootDirectory = $PSScriptRoot
            Write-Output "$GameRootDirectory"
            $SoundPlayerPath = "$GameRootDirectory\SoundPlayer.ps1"
            Write-Output "$SoundPlayerPath"
            $SoundPlayerPath = """$SoundPlayerPath"""
            Write-Output "$SoundPlayerPath"
            $textToAdd = "$LiteralPathString2 = $SoundPlayerPath"
            Write-Output "$textToAdd"
            Write-StringToFile -FilePath $filePath -String $textToAdd -LineNumber 1
            ##

            #Autosave Window Renderer Path
            $WindowRendererPath = "$GameRootDirectory\WindowRenderer.ps1"
            Write-Output "$WindowRendererPath"
            $WindowRendererPath = """$WindowRendererPath"""
            Write-Output "$WindowRendererPath"
            $textToAdd = "$LiteralPathString3 = $WindowRendererPath"
            Write-Output "$textToAdd"
            Write-StringToFile -FilePath $filePath -String $textToAdd -LineNumber 2
            ##

            ##Woah, we're halfway there, (with the install)
            [System.Windows.Forms.MessageBox]::Show("Finished first part of install. Please run again to finish install.")
            ##

            exit
        }
    } 
    
    if (Test-Path -Path "$GameRootPath" -ea Stop) {
        if ($SafeToRunGame -eq 0) {
            
            ##Message to let these mfs know the 2nd install has begun
            [System.Windows.Forms.MessageBox]::Show("Beginning 2nd half of install. I'll let you know when it's done.")
            ##

            ##Test to make sure it's safe to run this
            Test-Path -Path "$GameRootPath"
            Write-Output "$GameRootPath"
            $filePath = "$GameRootPath\Bio Simulator 2.ps1"
            Write-Output "$filePath"

            ##Autoset Location of WindowRenderer
            $WindowRendererPath = """$WindowRendererPath"""
            Write-Output "$WindowRendererPath"
            $textToAdd = "InlineScript {PowerShell -File $WindowRendererPath}"
            Write-Output "$textToAdd"
            Write-StringToFile -FilePath $filePath -String $textToAdd -LineNumber 163
            ##

            ##Autoset Location of SoundPlayer
            $SoundPlayerPath = """$SoundPlayerPath"""
            $textToAdd = "InlineScript {PowerShell -File $SoundPlayerPath}"
            Write-Output "$textToAdd"
            Write-StringToFile -FilePath $filePath -String $textToAdd -LineNumber 164
            ##

            ##Tell game it's safe to run
            $textToAdd = "$LiteralVariableString = 1"
            Write-Output "$textToAdd"
            Write-StringToFile -FilePath $filePath -String $textToAdd -LineNumber 3
            ##

            ##AWW YEAH. THIS IS HAPPENIN (We're done with the 2nd half of the install)
            [System.Windows.Forms.MessageBox]::Show("Finished 2nd part of install. Please run again to start the game.")
            ##

            exit
        }
    } 
    
    if ($SafeToRunGame = 1) {
        Workflow MultiThread {
            parallel {
                InlineScript {PowerShell -File "$null"}
                InlineScript {PowerShell -File "$null"}
            }
        }


        $GameWindow = 1



        while(1) {

            switch ($GameWindow) {

                1 {MultiThread
                $GameWindow++
                ;Break}
                2 {#pause
                $GameWindow++
                ;Break}
                3 {exit
                ;Break}
            }
          

        }
    }
