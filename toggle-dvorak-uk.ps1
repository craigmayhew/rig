$currentLangAndKeyboard = (Get-WinUserLanguageList).InputMethodTips

if ($currentLangAndKeyboard -eq "0809:00010409")
{
  $langList = New-WinUserLanguageList en-GB
  $langList[0].InputMethodTips.Clear()
  $langList[0].InputMethodTips.Add('0809:00000809') # English (United Kingdom) - QWERTY
  Set-WinUserLanguageList $langList
}
Else
{
  $langList = New-WinUserLanguageList en-US
  $langList[0].InputMethodTips.Clear()
  $langList[0].InputMethodTips.Add('0809:00010409') # English (United States) - US Dvorak
  Set-WinUserLanguageList $langList
}

