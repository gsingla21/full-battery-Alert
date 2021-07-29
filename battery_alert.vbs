set oLocator = CreateObject("WbemScripting.SWbemLocator")
set oServices = oLocator.ConnectServer(".","root\wmi")
set oResults = oServices.ExecQuery("select * from batteryfullchargedcapacity")
for each oResult in oResults
   iFull = oResult.FullChargedCapacity
next

Sub Play(SoundFile)
Dim Sound
Set Sound = CreateObject("WMPlayer.OCX")
Sound.URL = SoundFile
Sound.settings.volume = 100
Sound.Controls.play
do while Sound.currentmedia.duration = 0
    wscript.sleep 100
loop
wscript.sleep(int(Sound.currentmedia.duration)+1)*1000
End Sub

while (1)
  set oResults = oServices.ExecQuery("select * from batterystatus")
  for each oResult in oResults
    iRemaining = oResult.RemainingCapacity
    bCharging = oResult.Charging
  next
  iPercent = ((iRemaining / iFull) * 100) mod 100
  if bCharging and (iPercent > 98) Then 
  strSoundFile = "C:\Users\itsme\Music\Notify1.wav"
  Call Play(strSoundFile)
  msgbox "Battery is fully charged"
  end if
  wscript.sleep 30000 ' 5 minutes
wend
