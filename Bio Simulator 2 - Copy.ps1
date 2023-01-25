$GameRootPath = $null
$SoundPlayerPath = $null
$WindowRendererPath = $null
$SafeToRunGame = 0

$LiteralPathString1 = ('$GameRootPath')
$LiteralPathString2 = ('$SoundPlayerPath')
$LiteralPathString3 = ('$WindowRendererPath')
$LiteralVariableString = ('$SafeToRunGame')


#COMPILER SCRIPT 

#Invoke-ps2exe -inputFile "D:\Blake\Documents\Bio Simulator 2\Bio Simulator 2.ps1" -outputFile "D:\Blake\Documents\Bio Simulator 2\Bio Simulator 2.exe" -iconFile "D:\Blake\Documents\Bio Simulator 2\areyououtofyourfokinmind.ico" -title "Bio Simulator 2: Antirus Go Achoo" -description "Deep in the catacombs of Neverland Ranch lie a long-forgotten enemy, awakened after tens of thousands of years lying dormant..." -company "Andrew Tate Studios LLC" -version "69" -exitOnCancel -DPIAware -winFormsDPIAware


##DEPENENCIES
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Hide-Console
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

Hide-Console
cls

try {

    if ($GameRootPath -eq $null) {
        ##Prompt letting people know that it wants you to open itself
        [System.Windows.Forms.MessageBox]::Show("Please open the program you are currently running to begin installation.")
        ##

        #Ask to open file
        [void][Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')
        $BioSimulator2 = New-Object System.Windows.Forms.OpenFileDialog -Property @{ 
            InitialDirectory = [Environment]::GetFolderPath('MyComputer') 
            Filter = 'Bio Simulator 2|Bio Simulator 2.ps1'
        }
        $BioSimulator2.ShowDialog()
        $BioSimulator2Path = $BioSimulator2.FileName
        ##Write-Output "$BioSimulator2Path"

        ##

       
        if ($BioSimulator2Path -eq $null) {
            throw "Deez Nuts on your forehead"
        } else {

            #Autosave Game Root Path
            $GameRootPath = (Get-Item $BioSimulator2Path).DirectoryName
            $filePath = "$GameRootPath\Bio Simulator 2.ps1"
            Write-Output "$filePath"
            $GameRootPath = """$GameRootPath"""
            Write-Output "$GameRootPath"
            $lineNumber = 1
            $textToAdd = "$LiteralPathString1 = $GameRootPath"
            Write-Output "$textToAdd"
            $fileContent = Get-Content $filePath
            $fileContent[$lineNumber-1] = $textToAdd
            $fileContent | Set-Content $filePath
            ##

            ##Autosave Sound Player Path
            $GameRootDirectory = (Get-Item $BioSimulator2Path).DirectoryName
            Write-Output "$GameRootDirectory"
            $SoundPlayerPath = "$GameRootDirectory\SoundPlayer.ps1"
            Write-Output "$SoundPlayerPath"
            $SoundPlayerPath = """$SoundPlayerPath"""
            Write-Output "$SoundPlayerPath"
            $lineNumber = 2
            $textToAdd = "$LiteralPathString2 = $SoundPlayerPath"
            Write-Output "$textToAdd"
            $fileContent = Get-Content $filePath
            $fileContent[$lineNumber-1] = $textToAdd
            $fileContent | Set-Content $filePath
            ##

            #Autosave Window Renderer Path
            $WindowRendererPath = "$GameRootDirectory\WindowRenderer.ps1"
            Write-Output "$WindowRendererPath"
            $WindowRendererPath = """$WindowRendererPath"""
            Write-Output "$WindowRendererPath"
            $lineNumber = 3
            $textToAdd = "$LiteralPathString3 = $WindowRendererPath"
            Write-Output "$textToAdd"
            $fileContent = Get-Content $filePath
            $fileContent[$lineNumber-1] = $textToAdd
            $fileContent | Set-Content $filePath
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
            $lineNumber = 175
            $textToAdd = "InlineScript {PowerShell -File $WindowRendererPath}"
            Write-Output "$textToAdd"
            $fileContent = Get-Content $filePath
            $fileContent[$lineNumber-1] = $textToAdd
            $fileContent | Set-Content $filePath
            ##

            ##Autoset Location of SoundPlayer
            $SoundPlayerPath = """$SoundPlayerPath"""
            $lineNumber = 176
            $textToAdd = "InlineScript {PowerShell -File $SoundPlayerPath}"
            Write-Output "$textToAdd"
            $fileContent = Get-Content $filePath
            $fileContent[$lineNumber-1] = $textToAdd
            $fileContent | Set-Content $filePath
            ##

            ##Tell game it's safe to run
            $lineNumber = 4
            $textToAdd = "$LiteralVariableString = 1"
            Write-Output "$textToAdd"
            $fileContent = Get-Content $filePath
            $fileContent[$lineNumber-1] = $textToAdd
            $fileContent | Set-Content $filePath
            ##

            ##AWW YEAH. THIS IS HAPPENIN (We're done with the 2nd half of the install)
            [System.Windows.Forms.MessageBox]::Show("Finished 2nd part of install. Please run again to start the game.")
            ##

            exit
        } else {
            Write-Output "U Can't See This"
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
                2 {pause
                $GameWindow++
                ;Break}
                3 {exit
                ;Break}
            }
          

        }
    }
} catch {
    Write-Output "CATOSTROPHIC ERROR"
    [System.Windows.Forms.MessageBox]::Show("Error. Try running the program again.")
    exit
}
