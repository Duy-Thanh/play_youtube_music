param (
    [string]$Link
)
cmd.exe /c "`"C:\Users\Nekkochan\scoop\apps\yt-dlp\current\yt-dlp.exe`" --cookies `"C:\Users\Nekkochan\c1.txt`" -f ba -o - -- `"$Link`" | `"C:\Users\Nekkochan\scoop\apps\ffmpeg\current\bin\ffmpeg.exe`" -re -i - -c:a copy -f mpegts udp://127.0.0.1:1234?pkt_size=1316"
