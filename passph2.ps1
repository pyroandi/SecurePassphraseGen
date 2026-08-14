Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
[void][System.Windows.Forms.Application]::EnableVisualStyles()

$global:RNG = [System.Security.Cryptography.RandomNumberGenerator]::Create()

$ColorBg = [System.Drawing.Color]::FromArgb(24, 24, 24)
$ColorPanel = [System.Drawing.Color]::FromArgb(37, 37, 38)
$ColorText = [System.Drawing.Color]::FromArgb(212, 212, 212)
$ColorAccent = [System.Drawing.Color]::FromArgb(0, 122, 204)
$ColorBtn = [System.Drawing.Color]::FromArgb(51, 51, 51)

$FontMain = New-Object System.Drawing.Font("Segoe UI", 10)
$FontTitle = New-Object System.Drawing.Font("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)
$FontPass = New-Object System.Drawing.Font("Consolas", 18, [System.Drawing.FontStyle]::Bold)

$MainForm = New-Object System.Windows.Forms.Form
$MainForm.Text = "Sicherer Passphrase Generator"
$MainForm.Size = New-Object System.Drawing.Size(900, 800)
$MainForm.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen
$MainForm.BackColor = $ColorBg
$MainForm.ForeColor = $ColorText
$MainForm.Font = $FontMain
$MainForm.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedDialog
$MainForm.MaximizeBox = $false

$LblTitle = New-Object System.Windows.Forms.Label
$LblTitle.Text = "Mehrsprachiger Generator Dark Mode"
$LblTitle.Font = $FontTitle
$LblTitle.AutoSize = $true
$LblTitle.Location = New-Object System.Drawing.Point(20, 20)
[void]$MainForm.Controls.Add($LblTitle)

$LblLang = New-Object System.Windows.Forms.Label
$LblLang.Text = "Sprache:"
$LblLang.Location = New-Object System.Drawing.Point(20, 70)
$LblLang.AutoSize = $true
[void]$MainForm.Controls.Add($LblLang)

$ComboLanguage = New-Object System.Windows.Forms.ComboBox
$ComboLanguage.Location = New-Object System.Drawing.Point(120, 67)
$ComboLanguage.Size = New-Object System.Drawing.Size(150, 25)
$ComboLanguage.BackColor = $ColorPanel
$ComboLanguage.ForeColor = $ColorText
$ComboLanguage.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
[void]$ComboLanguage.Items.Add("Deutsch")
[void]$ComboLanguage.Items.Add("Englisch")
[void]$ComboLanguage.Items.Add("Portugiesisch")
[void]$ComboLanguage.Items.Add("Türkisch")
$ComboLanguage.SelectedIndex = 0
[void]$MainForm.Controls.Add($ComboLanguage)

$LblSep = New-Object System.Windows.Forms.Label
$LblSep.Text = "Trennzeichen:"
$LblSep.Location = New-Object System.Drawing.Point(300, 70)
$LblSep.AutoSize = $true
[void]$MainForm.Controls.Add($LblSep)

$ComboSeparator = New-Object System.Windows.Forms.ComboBox
$ComboSeparator.Location = New-Object System.Drawing.Point(400, 67)
$ComboSeparator.Size = New-Object System.Drawing.Size(100, 25)
$ComboSeparator.BackColor = $ColorPanel
$ComboSeparator.ForeColor = $ColorText
$ComboSeparator.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
[void]$ComboSeparator.Items.Add("_")
[void]$ComboSeparator.Items.Add("-")
[void]$ComboSeparator.Items.Add(",")
[void]$ComboSeparator.Items.Add(".")
[void]$ComboSeparator.Items.Add("/")
[void]$ComboSeparator.Items.Add("")
[void]$ComboSeparator.Items.Add("[None]")
$ComboSeparator.SelectedIndex = 1
[void]$MainForm.Controls.Add($ComboSeparator)

$LblWords = New-Object System.Windows.Forms.Label
$LblWords.Text = "Wörter 3 bis 12:"
$LblWords.Location = New-Object System.Drawing.Point(20, 120)
$LblWords.AutoSize = $true
[void]$MainForm.Controls.Add($LblWords)

$SliderWords = New-Object System.Windows.Forms.TrackBar
$SliderWords.Minimum = 3
$SliderWords.Maximum = 12
$SliderWords.Value = 3
$SliderWords.Location = New-Object System.Drawing.Point(120, 120)
$SliderWords.Size = New-Object System.Drawing.Size(150, 45)
[void]$MainForm.Controls.Add($SliderWords)

$LblWordCountValue = New-Object System.Windows.Forms.Label
$LblWordCountValue.Text = "3"
$LblWordCountValue.Font = $FontTitle
$LblWordCountValue.Location = New-Object System.Drawing.Point(280, 120)
$LblWordCountValue.AutoSize = $true
[void]$MainForm.Controls.Add($LblWordCountValue)

$SliderWords.Add_Scroll({
    $LblWordCountValue.Text = $SliderWords.Value.ToString()
})

$LblNum = New-Object System.Windows.Forms.Label
$LblNum.Text = "Anzahl Zahlen:"
$LblNum.Location = New-Object System.Drawing.Point(20, 170)
$LblNum.AutoSize = $true
[void]$MainForm.Controls.Add($LblNum)

$SliderNumbers = New-Object System.Windows.Forms.TrackBar
$SliderNumbers.Minimum = 0
$SliderNumbers.Maximum = 10
$SliderNumbers.Value = 1
$SliderNumbers.Location = New-Object System.Drawing.Point(120, 170)
$SliderNumbers.Size = New-Object System.Drawing.Size(150, 45)
[void]$MainForm.Controls.Add($SliderNumbers)

$LblNumValue = New-Object System.Windows.Forms.Label
$LblNumValue.Text = "1"
$LblNumValue.Font = $FontTitle
$LblNumValue.Location = New-Object System.Drawing.Point(280, 170)
$LblNumValue.AutoSize = $true
[void]$MainForm.Controls.Add($LblNumValue)

$SliderNumbers.Add_Scroll({
    $LblNumValue.Text = $SliderNumbers.Value.ToString()
})

$LblSym = New-Object System.Windows.Forms.Label
$LblSym.Text = "Sonderzeichen:"
$LblSym.Location = New-Object System.Drawing.Point(320, 170)
$LblSym.AutoSize = $true
[void]$MainForm.Controls.Add($LblSym)

$SliderSymbols = New-Object System.Windows.Forms.TrackBar
$SliderSymbols.Minimum = 0
$SliderSymbols.Maximum = 10
$SliderSymbols.Value = 1
$SliderSymbols.Location = New-Object System.Drawing.Point(430, 170)
$SliderSymbols.Size = New-Object System.Drawing.Size(150, 45)
[void]$MainForm.Controls.Add($SliderSymbols)

$LblSymValue = New-Object System.Windows.Forms.Label
$LblSymValue.Text = "1"
$LblSymValue.Font = $FontTitle
$LblSymValue.Location = New-Object System.Drawing.Point(590, 170)
$LblSymValue.AutoSize = $true
[void]$MainForm.Controls.Add($LblSymValue)

$SliderSymbols.Add_Scroll({
    $LblSymValue.Text = $SliderSymbols.Value.ToString()
})

$LblCaps = New-Object System.Windows.Forms.Label
$LblCaps.Text = "Schreibweise:"
$LblCaps.Location = New-Object System.Drawing.Point(20, 230)
$LblCaps.AutoSize = $true
[void]$MainForm.Controls.Add($LblCaps)

$ComboCaps = New-Object System.Windows.Forms.ComboBox
$ComboCaps.Location = New-Object System.Drawing.Point(125, 227)
$ComboCaps.Size = New-Object System.Drawing.Size(180, 25)
$ComboCaps.BackColor = $ColorPanel
$ComboCaps.ForeColor = $ColorText
$ComboCaps.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
[void]$ComboCaps.Items.Add("Alles klein")
[void]$ComboCaps.Items.Add("Jedes Wort groß")
[void]$ComboCaps.Items.Add("Alles groß")
$ComboCaps.SelectedIndex = 2
[void]$MainForm.Controls.Add($ComboCaps)

$BtnGenerate = New-Object System.Windows.Forms.Button
$BtnGenerate.Text = "PASSPHRASE GENERIEREN"
$BtnGenerate.Location = New-Object System.Drawing.Point(20, 280)
$BtnGenerate.Size = New-Object System.Drawing.Size(840, 50)
$BtnGenerate.BackColor = [System.Drawing.Color]::FromArgb(40, 167, 69)
$BtnGenerate.ForeColor = [System.Drawing.Color]::White
$BtnGenerate.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$BtnGenerate.FlatAppearance.BorderSize = 0
$BtnGenerate.Font = $FontTitle
$BtnGenerate.Cursor = [System.Windows.Forms.Cursors]::Hand
[void]$MainForm.Controls.Add($BtnGenerate)

$OutputBox = New-Object System.Windows.Forms.TextBox
$OutputBox.Multiline = $true
$OutputBox.ReadOnly = $true
$OutputBox.Location = New-Object System.Drawing.Point(20, 350)
$OutputBox.Size = New-Object System.Drawing.Size(840, 120)
$OutputBox.Font = $FontPass
$OutputBox.BackColor = $ColorPanel
$OutputBox.ForeColor = [System.Drawing.Color]::FromArgb(92, 230, 205)
$OutputBox.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
$OutputBox.Text = "Bitte auf Generieren klicken"
[void]$MainForm.Controls.Add($OutputBox)

$LblHistory = New-Object System.Windows.Forms.Label
$LblHistory.Text = "Historie Letzte 10"
$LblHistory.Location = New-Object System.Drawing.Point(20, 490)
$LblHistory.AutoSize = $true
[void]$MainForm.Controls.Add($LblHistory)

$HistoryList = New-Object System.Windows.Forms.ListBox
$HistoryList.Location = New-Object System.Drawing.Point(20, 520)
$HistoryList.Size = New-Object System.Drawing.Size(840, 180)
$HistoryList.BackColor = $ColorPanel
$HistoryList.ForeColor = [System.Drawing.Color]::FromArgb(160, 160, 160)
$HistoryList.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
$HistoryList.Font = New-Object System.Drawing.Font("Consolas", 12)
[void]$MainForm.Controls.Add($HistoryList)

$global:Wordlists = @{
    "Deutsch" = @()
    "Englisch" = @()
    "Portugiesisch" = @()
    "Türkisch" = @()
}

function Get-CryptoRandomInt {
    param ([int]$Min, [int]$Max)
    $bytes = New-Object byte[] 4
    $global:RNG.GetBytes($bytes)
    $scale = [System.BitConverter]::ToUInt32($bytes, 0)
    if ($scale -eq 0) {
        return $Min
    }
    $divisor = 4294967296.0 / $scale
    $diff = $Max - $Min
    $randomValue = $Min + [int]($diff / $divisor)
    return $randomValue
}

function Invoke-FisherYatesShuffle {
    param([array]$Array)
    $shuffled = $Array.Clone()
    $i = $shuffled.Length - 1
    while ($i -gt 0) {
        $j = Get-CryptoRandomInt -Min 0 -Max ($i + 1)
        $temp = $shuffled[$i]
        $shuffled[$i] = $shuffled[$j]
        $shuffled[$j] = $temp
        $i--
    }
    return $shuffled
}

function Get-Wordlist {
    param ([string]$Language)
    if ($global:Wordlists[$Language].Count -gt 0) {
        return $global:Wordlists[$Language]
    }
    $MainForm.Cursor = [System.Windows.Forms.Cursors]::WaitCursor
    $OutputBox.Text = "Lade Wortliste"
    [void][System.Windows.Forms.Application]::DoEvents()
    try {
        $words = @()
        switch ($Language) {
            "Deutsch" {
                $url = "https://raw.githubusercontent.com/bjoernalbers/diceware-wordlist-german/main/wordlist-german-lowercase.txt"
                $data = Invoke-RestMethod -Uri $url
                $words = ($data -split [char]10 | Where-Object { $_ -match "^[a-zßäöü]+$" })
            }
            "Englisch" {
                $url = "https://www.eff.org/files/2016/07/18/eff_large_wordlist.txt"
                $data = Invoke-RestMethod -Uri $url
                $words = ($data -split [char]10 | Where-Object { $_ -match "^\d+\s+([a-z]+)" } | ForEach-Object { $matches[1] })
            }
            "Portugiesisch" {
                $url = "https://gist.githubusercontent.com/patxipierce/3a96b1927b844ce47c04a242651bafc2/raw/diceware.wordlist.pt.txt"
                $data = Invoke-RestMethod -Uri $url
                $words = ($data -split [char]10 | Where-Object { $_ -match "^\d{5}\s+([a-z]+)" } | ForEach-Object { $matches[1] })
            }
            "Türkisch" {
                $url = "https://raw.githubusercontent.com/canerbasaran/diceware_tr/master/diceware_tr.txt"
                $data = Invoke-RestMethod -Uri $url
                $words = ($data -split [char]10 | Where-Object { $_ -match "^\d{5}\s+([a-zçğıöşü]+)" } | ForEach-Object { $matches[1] })
            }
        }
        if ($words.Count -lt 500) { throw "Fehler beim Laden" }
        $global:Wordlists[$Language] = $words
        $OutputBox.Text = "Bereit"
    }
    catch {
        $OutputBox.Text = "Fehler beim Laden"
    }
    finally {
        $MainForm.Cursor = [System.Windows.Forms.Cursors]::Default
    }
    return $global:Wordlists[$Language]
}

function New-Passphrase {
    $Language = $ComboLanguage.SelectedItem.ToString()
    $WordCount = $SliderWords.Value
    $Separator = $ComboSeparator.SelectedItem.ToString()
    $NumCount = $SliderNumbers.Value
    $SymCount = $SliderSymbols.Value
    $CapsMode = $ComboCaps.SelectedItem.ToString()

    if ($Separator -eq "") { $Separator = " " }
    if ($Separator -eq "[None]") { $Separator = "" }

    $corpus = Get-Wordlist -Language $Language
    if ($corpus.Count -eq 0) { return }

    $numberChars = [char[]]"0123456789"
    $symbolChars = [char[]]"!$&%?@+/<>:"
    
    $words = @()
    $i = 0
    while ($i -lt $WordCount) {
        $baseWord = $corpus[(Get-CryptoRandomInt -Min 0 -Max $corpus.Count)].Trim()
        switch ($CapsMode) {
            "Jedes Wort groß" { $baseWord = $baseWord.Substring(0, 1).ToUpper() + $baseWord.Substring(1).ToLower() }
            "Alles groß" { $baseWord = $baseWord.ToUpper() }
            "Alles klein" { $baseWord = $baseWord.ToLower() }
        }
        $words += $baseWord
        $i++
    }

    $extraChars = @()
    $i = 0
    while ($i -lt $NumCount) { 
        $extraChars += $numberChars[(Get-CryptoRandomInt -Min 0 -Max $numberChars.Length)] 
        $i++
    }
    
    $i = 0
    while ($i -lt $SymCount) { 
        $extraChars += $symbolChars[(Get-CryptoRandomInt -Min 0 -Max $symbolChars.Length)] 
        $i++
    }
    
    $extraChars = Invoke-FisherYatesShuffle -Array $extraChars

    $i = 0
    while ($i -lt $extraChars.Count) {
        $wordIndex = Get-CryptoRandomInt -Min 0 -Max $words.Count
        $isPrefix = (Get-CryptoRandomInt -Min 0 -Max 2) -eq 0
        $charToAdd = $extraChars[$i]

        if ($isPrefix) {
            $words[$wordIndex] = "$charToAdd" + $words[$wordIndex]
        } else {
            $words[$wordIndex] = $words[$wordIndex] + "$charToAdd"
        }
        $i++
    }

    $finalPassphrase = $words -join $Separator

    $OutputBox.Text = $finalPassphrase
    if ($HistoryList.Items.Count -ge 10) {
        [void]$HistoryList.Items.RemoveAt(9)
    }
    [void]$HistoryList.Items.Insert(0, $finalPassphrase)
}

$BtnGenerate.Add_Click({ New-Passphrase })

$MainForm.Add_FormClosing({
    $OutputBox.Text = "00000000"
    $HistoryList.Items.Clear()
    $global:Wordlists.Clear()
    if ($global:RNG) { $global:RNG.Dispose() }
    [System.GC]::Collect()
})

[void]$MainForm.ShowDialog()