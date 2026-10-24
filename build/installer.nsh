; Chesspresso Eşleştirme — NSIS kurulum eklentileri (electron-builder "include")

!macro customInit
  ; 1.0.0 sürümü Squirrel ile %LOCALAPPDATA%\chesspresso altına kurulmuştu.
  ; Yeni sürümle iki ayrı kopya ve iki kısayol kalmasın diye önce onu kaldırırız.
  ; Turnuva verileri (%APPDATA%\Chesspresso Eşleştirme) korunur.
  IfFileExists "$LOCALAPPDATA\chesspresso\Update.exe" 0 chesspresso_eski_yok
    ; Açık pencere önce nazikçe kapatılır (kayıtlar diske yazılsın), gerekirse zorla.
    nsExec::Exec 'taskkill /IM chesspresso.exe'
    Pop $0
    Sleep 1500
    nsExec::Exec 'taskkill /F /IM chesspresso.exe /T'
    Pop $0
    ExecWait '"$LOCALAPPDATA\chesspresso\Update.exe" --uninstall -s'
    Sleep 1500
    RMDir /r "$LOCALAPPDATA\chesspresso"
  chesspresso_eski_yok:
!macroend
