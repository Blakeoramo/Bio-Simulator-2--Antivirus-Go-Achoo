#COMPILER SCRIPT 

#Invoke-ps2exe -inputFile "D:\Blake\Documents\Bio Simulator 2\Bio Simulator 2.ps1" -outputFile "D:\Blake\Documents\Bio Simulator 2\Bio Simulator 2.exe" -iconFile "D:\Blake\Documents\Bio Simulator 2\areyououtofyourfokinmind.ico" -title "Bio Simulator 2: Antirus Go Achoo" -description "Deep in the catacombs of Neverland Ranch lie a long-forgotten enemy, awakened after tens of thousands of years lying dormant..." -company "Andrew Tate Studios LLC" -version "69" -exitOnCancel -DPIAware -winFormsDPIAware


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
    # Check if the line number is within bounds
    If ($LineNumber -gt $newContent.Length) {
        # Add blank lines to the array until the line number is within bounds
        For ($i = $newContent.Length; $i -lt $LineNumber; $i++) {
            $newContent += ""
        }
    }
    Try {
        $newContent[$LineNumber] = $String
    } Catch {
        Write-Warning "Line number is outside the bounds of the array. Continuing with the script."
    }
    Set-Content -Path $FilePath -Value ($newContent -join "`n")
}

Hide-Console
cls

function Install-Game {
        
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
            ##Autosave Game Root Path
            $GameRootPath = $PSScriptRoot
            $filePath = "$GameSaveFile"
            Write-Output "$filePath"
            Write-Output "$GameRootPath"
            $textToAdd = "$GameRootPath"
            Write-Output "$textToAdd"
            Write-StringToFile -FilePath $GameSaveFile -String $textToAdd -LineNumber 0
            #

            ##Autosave Sound Player Path
            $GameRootDirectory = $PSScriptRoot
            Write-Output "$GameRootDirectory"
            $SoundPlayerPath = "$GameRootDirectory\SoundPlayer.ps1"
            Write-Output "$SoundPlayerPath"
            $textToAdd = "$SoundPlayerPath"
            Write-Output "$textToAdd"
            Write-StringToFile -FilePath $GameSaveFile -String $textToAdd -LineNumber 1
            #

            ##Autosave Window Renderer Path
            $WindowRendererPath = "$GameRootDirectory\WindowRenderer.ps1"
            Write-Output "$WindowRendererPath"
            $textToAdd = "$WindowRendererPath"
            Write-Output "$textToAdd"
            Write-StringToFile -FilePath $GameSaveFile -String $textToAdd -LineNumber 2
            #

            ##Tell the game that it's safe to launch
            $textToAdd = "1"
            Write-Output "$textToAdd"
            Write-StringToFile -FilePath $GameSaveFile -String $textToAdd -LineNumber 3
            #

            ##Woah, we're halfway there, (with the install)
            [System.Windows.Forms.MessageBox]::Show("Finished install. Please run again to run game.")
            #

            exit
        } 
}

if (-not(Test-Path "C:\ProgramData\Bio Simulator 2\Save.File")) {

    ##Creates Game Save File Path
    $GameSaveFile = "C:\ProgramData\Bio Simulator 2\Save.File"
    ##Creates Game Save File and adds 100 lines
    Write-StringToFile -FilePath $GameSaveFile -String "PlaceHolder" -LineNumber 9
    ##Installs Game
    Install-Game
    #

} else {

    ##Game Paths
    $GameSaveFile = "C:\ProgramData\Bio Simulator 2\Save.File"
    #$GameRootPath = (Get-Content $GameSaveFile)[1]
    #$SoundPlayerPath = (Get-Content $GameSaveFile)[2]
    #$WindowRendererPath = (Get-Content $GameSaveFile)[3]
    $SafeToRunGame = (Get-Content $GameSaveFile)[4]
    #

    if ($SafeToRunGame = 1) {
        Workflow MultiThread {
            parallel {
                InlineScript {$GameSaveFile = "C:\ProgramData\Bio Simulator 2\Save.File"
                              $WindowRendererPath = (Get-Content $GameSaveFile)[2]
                              ##Write-Output $WindowRendererPath
                              PowerShell -File $WindowRendererPath}
                InlineScript {$GameSaveFile = "C:\ProgramData\Bio Simulator 2\Save.File"
                              $SoundPlayerPath = (Get-Content $GameSaveFile)[1]
                              ##Write-Output $SoundPlayerPath
                              PowerShell -File $SoundPlayerPath}
            }
        }


        $GameWindow = 1


        ##Main Game Loop
        while(1) {

            switch ($GameWindow) {

                1 {MultiThread
                $GameWindow++
                ;Break}
                2 {##pause
                $GameWindow++
                ;Break}
                3 {exit
                ;Break}
            }
          

        }
        #
    }
}
