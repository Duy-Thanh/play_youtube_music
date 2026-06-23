param (
    [string]$Link
)
cmd.exe /c "`"%USERPROFILE%\scoop\apps\yt-dlp\current\yt-dlp.exe`" --cookies `"%USERPROFILE%\c1.txt`" -f ba -o - -- `"$Link`" | `"%USERPROFILE%\scoop\apps\ffmpeg\current\bin\ffmpeg.exe`" -re -i - -c:a copy -f mpegts udp://127.0.0.1:1234?pkt_size=1316"
