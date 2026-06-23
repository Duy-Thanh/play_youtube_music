$DebugPreference = "SilentlyContinue"

Stop-Process -Name "ffmpeg", "vlc" -Force -ErrorAction SilentlyContinue

Write-Host "[*] Dang khoi dong VLC mo san cong cho vao RAM..." -ForegroundColor Cyan
Start-Process "C:\Program Files\VideoLAN\VLC\vlc.exe" -ArgumentList "--no-video", "--network-caching=150", "udp://@127.0.0.1:1234"
Start-Sleep -Seconds 2

do {
    Clear-Host
    Write-Host "===================================================" -ForegroundColor Green
    Write-Host "     YT-MUSIC TO VLC STREAMER (PURE UDP ZERO-LOSS)  " -ForegroundColor Green
    Write-Host "===================================================" -ForegroundColor Green
    Write-Host ""
    
    $ytmuxlink = Read-Host "--> Enter YouTube link (or type 'exit' to quit)"
    
    if ($ytmuxlink -eq "exit") { break }
    
    Write-Host ""
    Write-Host "[*] Dang ban truc tiep luong Opus vao loa..." -ForegroundColor Yellow
    Write-Host "[!] Dang stream ngam tai cua so rieng, menu giu nguyen sach se!" -ForegroundColor Gray
    
    Stop-Process -Name "ffmpeg" -Force -ErrorAction SilentlyContinue
    
    Start-Process powershell -ArgumentList "-NoProfile", "-File", "core_worker.ps1", "-Link", "$ytmuxlink"
    
    Start-Sleep -Seconds 2

} while ($true)

# Khi gõ exit, dọn sạch chiến trường
Stop-Process -Name "ffmpeg", "vlc" -Force -ErrorAction SilentlyContinue