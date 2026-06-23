$DebugPreference = "SilentlyContinue"

# 1. KHỞI TẠO TẬP LỆNH: DỌN SẠCH TIẾN TRÌNH CŨ
Stop-Process -Name "ffmpeg", "vlc" -Force -ErrorAction SilentlyContinue

Write-Host "[*] Dang khoi dong VLC mo san cong cho vao RAM..." -ForegroundColor Cyan
# Thằng VLC ôm cứng cổng mạng udp://@127.0.0.1:1234 từ đầu đến cuối đời. 
# Đéo bao giờ báo lỗi MRL rách rưởi nữa vì UDP đéo quan tâm luồng đã online hay chưa!
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
    
    # 2. KHỞI CHẠY NGUỒN PHÁT: Tắt con ffmpeg cũ (nếu đang đổi bài giữa chừng) để giải phóng cổng
    Stop-Process -Name "ffmpeg" -Force -ErrorAction SilentlyContinue
    
    # Kích nổ luồng: core_worker sẽ mở một cửa sổ PowerShell phụ để chạy, hiện phần trăm tải của yt-dlp ở đó.
    Start-Process powershell -ArgumentList "-NoProfile", "-File", "C:\mediamtx\core_worker.ps1", "-Link", "$ytmuxlink"
    
    # Chờ 2 giây để luồng bắt nhịp phẳng lỳ rồi cho mày rảnh tay gõ tiếp bài sau luôn
    Start-Sleep -Seconds 2

} while ($true)

# Khi gõ exit, dọn sạch chiến trường
Stop-Process -Name "ffmpeg", "vlc" -Force -ErrorAction SilentlyContinue