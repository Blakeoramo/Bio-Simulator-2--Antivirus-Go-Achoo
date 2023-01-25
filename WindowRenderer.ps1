#COMPILER SCRIPT 

#Invoke-ps2exe -inputFile "D:\Blake\Documents\Bio Simulator 2\Bio Simulator 2.ps1" -outputFile "D:\Blake\Documents\Bio Simulator 2\Bio Simulator 2.exe" -iconFile "D:\Blake\Documents\Bio Simulator 2\areyououtofyourfokinmind.ico" -title "Bio Simulator 2: Antirus Go Achoo" -description "Deep in the catacombs of Neverland Ranch lie a long-forgotten enemy, awakened after tens of thousands of years lying dormant..." -company "Andrew Tate Studios LLC" -version "69" -exitOnCancel -DPIAware -winFormsDPIAware

##DEPENENCIES
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()
Add-Type -AssemblyName System.Drawing
Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();

[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'


$WindowWidth = 1280
$WindowHeight = 720

$OriginHeight = ($WindowHeight / 2)
$OriginWidth = ($WindowWidth / 2)
$QuarterHeight = ($WindowHeight * 0.25)
$QuarterWidth = ($WindowWidth * 0.25)
$UpperWindow = ($OriginHeight - $QuarterHeight)
$LowerWindow = ($OriginHeight + $QuarterHeight)
$LefterWindow = ($OriginWidth - $QuarterWidth)
$RighterWindow = ($OriginWidth + $QuarterWidth)
$TotalPixels = ($WindowWidth * $WindowHeight)

$SquaredResolution = [Math]::Sqrt($TotalPixels)
$SquaredPixel = [Math]::Sqrt($SquaredResolution)


$AspectRatio = ($WindowWidth / $WindowHeight)


function Hide-Console {

$consolePtr = [Console.Window]::GetConsoleWindow()
    #0 hide
    [Console.Window]::ShowWindow($consolePtr, 0)
}


#function Increment-Value-Up {
    #for ($WindowPosition = 300; $WindowPosition -lt 601; $WindowPosition++) { 
    #}
#}

#while (1) {
    #Increment-Value-Up
#}
Hide-Console
function Intro-Window {
$form = New-Object System.Windows.Forms.Form
$form.Text = 'Bio Simulator 2: Antivirus go Achoo'
$form.Font = 'Arial Black'
$form.ForeColor = '0x004FBF'
$form.BackColor = '0xC0C0C0'
$form.Size = New-Object System.Drawing.Size($WindowWidth,$WindowHeight)
#$form.MaximumSize = $form.Size
#$form.MinimumSize = $form.size
$form.AutoScale = $true
$form.AutoScaleMode = "Font"
#$form.AutoSize = $true
$form.AutoSizeMode = "GrowAndShrink"
$form.StartPosition = 'CenterScreen'
$form.MaximizeBox = $false
$form.MinimizeBox = $false
$form.ShowInTaskbar = $true
$iconBase64      = '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'
$iconBytes       = [Convert]::FromBase64String($iconBase64)
$iconstream          = [System.IO.MemoryStream]::new($iconBytes, 0, $iconBytes.Length)
$Form.Icon       = [System.Drawing.Icon]::FromHandle(([System.Drawing.Bitmap]::new($iconstream).GetHIcon()))
#$stream.Dispose()
#$Form.Dispose()

$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(($SquaredPixel * 15),($SquaredPixel + $LowerWindow))
$okButton.Size = New-Object System.Drawing.Size((180 * $AspectRatio),23)
$okButton.Text = 'Who???????????'
$okButton.ForeColor = '0xFFFFFF'
$okButton.BackColor = '0x5F5FBF'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(($SquaredPixel * 14.5),($SquaredPixel))
$label.Size = New-Object System.Drawing.Size((360 * $AspectRatio),20)
$label.Text = 'Please enter your bitch ass name below:'
$label.Font = 'Arial Black, 11'
$form.Controls.Add($label)

$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(($SquaredPixel * 12),($OriginHeight - $SquaredPixel))
$textBox.Size = New-Object System.Drawing.Size((300 * $AspectRatio),20)
$textBox.ForeColor = '0x5F5FBF'
$textBox.TextAlign = 'Center'
$form.Controls.Add($textBox)

$form.Topmost = $true

$form.Add_Shown({$textBox.Select()})
$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $x = $textBox.Text
    $x
}
}

$GameWindow = Intro-Window
pause