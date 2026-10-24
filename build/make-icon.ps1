# Uygulama simgesini (build/icon.png ve build/icon.ico) çizer. Windows PowerShell 5.1 ile çalıştırın.
Add-Type -AssemblyName System.Drawing
$here = Split-Path -Parent $MyInvocation.MyCommand.Path

function New-IconBitmap([int]$size) {
  $bmp = New-Object System.Drawing.Bitmap $size, $size
  $g = [System.Drawing.Graphics]::FromImage($bmp)
  $g.SmoothingMode = 'AntiAlias'
  $g.TextRenderingHint = 'AntiAliasGridFit'
  $g.Clear([System.Drawing.Color]::Transparent)
  $r = [single]($size * 0.22)
  $path = New-Object System.Drawing.Drawing2D.GraphicsPath
  $d = $r * 2
  $path.AddArc(0, 0, $d, $d, 180, 90)
  $path.AddArc($size - $d - 1, 0, $d, $d, 270, 90)
  $path.AddArc($size - $d - 1, $size - $d - 1, $d, $d, 0, 90)
  $path.AddArc(0, $size - $d - 1, $d, $d, 90, 90)
  $path.CloseFigure()
  $g.FillPath((New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 30, 106, 80))), $path)
  $font = New-Object System.Drawing.Font 'Segoe UI Symbol', ([single]($size * 0.8)), ([System.Drawing.FontStyle]::Regular), ([System.Drawing.GraphicsUnit]::Pixel)
  $sf = New-Object System.Drawing.StringFormat
  $sf.Alignment = 'Center'
  $sf.LineAlignment = 'Center'
  $rect = New-Object System.Drawing.RectangleF 0, ([single]($size * 0.02)), $size, $size
  $g.DrawString([string][char]0x265E, $font, [System.Drawing.Brushes]::White, $rect, $sf)
  $g.Dispose()
  return $bmp
}

$big = New-IconBitmap 512
$big.Save((Join-Path $here 'icon.png'), [System.Drawing.Imaging.ImageFormat]::Png)

# Çok boyutlu ICO (PNG sıkıştırmalı girdiler)
$sizes = 16, 24, 32, 48, 64, 128, 256
$pngs = foreach ($s in $sizes) {
  $b = New-IconBitmap $s
  $ms = New-Object System.IO.MemoryStream
  $b.Save($ms, [System.Drawing.Imaging.ImageFormat]::Png)
  , $ms.ToArray()
}
$out = New-Object System.IO.MemoryStream
$w = New-Object System.IO.BinaryWriter $out
$w.Write([uint16]0); $w.Write([uint16]1); $w.Write([uint16]$sizes.Count)
$offset = 6 + 16 * $sizes.Count
for ($i = 0; $i -lt $sizes.Count; $i++) {
  $s = $sizes[$i]; $len = $pngs[$i].Length
  $w.Write([byte]($(if ($s -ge 256) { 0 } else { $s })))
  $w.Write([byte]($(if ($s -ge 256) { 0 } else { $s })))
  $w.Write([byte]0); $w.Write([byte]0)
  $w.Write([uint16]1); $w.Write([uint16]32)
  $w.Write([uint32]$len); $w.Write([uint32]$offset)
  $offset += $len
}
foreach ($p in $pngs) { $w.Write($p) }
$w.Flush()
[System.IO.File]::WriteAllBytes((Join-Path $here 'icon.ico'), $out.ToArray())

# Tarayıcıdan yükleme (PWA) simgeleri
$icons = Join-Path (Split-Path -Parent $here) 'icons'
New-Item -ItemType Directory -Force $icons | Out-Null
(New-IconBitmap 192).Save((Join-Path $icons 'icon-192.png'), [System.Drawing.Imaging.ImageFormat]::Png)
(New-IconBitmap 512).Save((Join-Path $icons 'icon-512.png'), [System.Drawing.Imaging.ImageFormat]::Png)
# "maskable": kenara kadar yeşil zemin, at güvenli alanın içinde
$m = New-Object System.Drawing.Bitmap 512, 512
$g = [System.Drawing.Graphics]::FromImage($m)
$g.SmoothingMode = 'AntiAlias'; $g.TextRenderingHint = 'AntiAliasGridFit'
$g.Clear([System.Drawing.Color]::FromArgb(255, 30, 106, 80))
$font = New-Object System.Drawing.Font 'Segoe UI Symbol', ([single]300), ([System.Drawing.FontStyle]::Regular), ([System.Drawing.GraphicsUnit]::Pixel)
$sf = New-Object System.Drawing.StringFormat; $sf.Alignment = 'Center'; $sf.LineAlignment = 'Center'
$g.DrawString([string][char]0x265E, $font, [System.Drawing.Brushes]::White, (New-Object System.Drawing.RectangleF 0, 8, 512, 512), $sf)
$g.Dispose()
$m.Save((Join-Path $icons 'maskable-512.png'), [System.Drawing.Imaging.ImageFormat]::Png)

# Kurulum sihirbazı görselleri (NSIS): kenar çubuğu 164x314, başlık 150x57 — 24 bit BMP
function Save-Bmp24($bmp, $path) {
  $c = $bmp.Clone((New-Object System.Drawing.Rectangle 0, 0, $bmp.Width, $bmp.Height), [System.Drawing.Imaging.PixelFormat]::Format24bppRgb)
  $c.Save($path, [System.Drawing.Imaging.ImageFormat]::Bmp)
}
$sb = New-Object System.Drawing.Bitmap 164, 314
$g = [System.Drawing.Graphics]::FromImage($sb)
$g.SmoothingMode = 'AntiAlias'; $g.TextRenderingHint = 'AntiAliasGridFit'
$grad = New-Object System.Drawing.Drawing2D.LinearGradientBrush (New-Object System.Drawing.Point 0, 0), (New-Object System.Drawing.Point 0, 314), ([System.Drawing.Color]::FromArgb(255, 34, 122, 92)), ([System.Drawing.Color]::FromArgb(255, 20, 74, 56))
$g.FillRectangle($grad, 0, 0, 164, 314)
$g.DrawImage((New-IconBitmap 88), 38, 46, 88, 88)
$white = [System.Drawing.Brushes]::White
$soft = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(210, 255, 255, 255))
$sfc = New-Object System.Drawing.StringFormat; $sfc.Alignment = 'Center'
$g.DrawString('Chesspresso', (New-Object System.Drawing.Font 'Segoe UI Semibold', ([single]17), ([System.Drawing.FontStyle]::Regular), ([System.Drawing.GraphicsUnit]::Pixel)), $white, (New-Object System.Drawing.RectangleF 0, 150, 164, 26), $sfc)
$g.DrawString('Eşleştirme', (New-Object System.Drawing.Font 'Segoe UI', ([single]14), ([System.Drawing.FontStyle]::Regular), ([System.Drawing.GraphicsUnit]::Pixel)), $soft, (New-Object System.Drawing.RectangleF 0, 174, 164, 22), $sfc)
$g.DrawString('İsviçre sistemi satranç' + "`n" + 'eşleştirme ve sıralama', (New-Object System.Drawing.Font 'Segoe UI', ([single]11), ([System.Drawing.FontStyle]::Regular), ([System.Drawing.GraphicsUnit]::Pixel)), $soft, (New-Object System.Drawing.RectangleF 0, 262, 164, 40), $sfc)
$g.Dispose()
Save-Bmp24 $sb (Join-Path $here 'installerSidebar.bmp')

$hd = New-Object System.Drawing.Bitmap 150, 57
$g = [System.Drawing.Graphics]::FromImage($hd)
$g.SmoothingMode = 'AntiAlias'
$g.Clear([System.Drawing.Color]::White)
$g.DrawImage((New-IconBitmap 44), 100, 6, 44, 44)
$g.Dispose()
Save-Bmp24 $hd (Join-Path $here 'installerHeader.bmp')
Write-Output "Simgeler ve kurulum görselleri oluşturuldu"
