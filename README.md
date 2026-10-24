<p align="center">
  <img src="build/icon.png" width="96" alt="Chesspresso simgesi">
</p>

<h1 align="center">Chesspresso Eşleştirme</h1>

<p align="center">
  İsviçre sistemi satranç turnuvaları için ücretsiz, Türkçe eşleştirme ve sıralama programı.<br>
  İnternet gerektirmez · Kurulumlu masaüstü uygulaması veya tek HTML dosyası
</p>

<p align="center">
  <a href="https://github.com/etgazavalsiz/chesspresso-eslestirme/releases/latest"><b>⬇ Windows için indir</b></a>
  &nbsp;·&nbsp;
  <a href="#kurulumsuz-kullanım">Kurulumsuz kullan</a>
  &nbsp;·&nbsp;
  <a href="#eşleştirme-kuralları">Eşleştirme kuralları</a>
</p>

![Eşleştirme ekranı](docs/eslestirme.png)

## Özellikler

- **Otomatik İsviçre eşleştirmesi** — Puan grupları, Hollanda (Dutch) sistemi mantığı, tekrar eşleşme yok, renk dengesi, otomatik bay. Her tur tek tıkla.
- **Sonuç girişi** — 1–0, ½–½, 0–1 ve hükmen sonuçlar (+/−, −/+, −/−).
- **Sıralama ve averajlar** — Buchholz, Buchholz Kesik-1, Medyan Buchholz, Sonneborn-Berger, aralarındaki maç, galibiyet sayısı, siyahla oynanan, kademeli puan, rakip ELO ortalaması. Sırasını siz belirlersiniz.
- **Çapraz tablo** — Her oyuncunun tur tur rakibi, rengi ve sonucu.
- **PDF indirme** — Tur eşleştirmesi/sonuçları, sıralama, çapraz tablo ve tüm turnuva raporu. Türkçe karakterler sorunsuz.
- **Excel (CSV) aktarımı**, yazdırma, yedekleme (.json) ve yedekten yükleme.
- **Katılım yönetimi** — Tura gelmeyecek oyuncuları "izinli (½)" veya "gelmeyecek (0)" işaretleyin; turnuvadan çekilme, geç katılım.
- **Elle düzenleme** — Gerekirse eşleştirmede iki oyuncunun yerini veya bir masanın renklerini değiştirin.
- **Birden çok turnuva** — Hepsi bilgisayarınızda saklanır; açık ve koyu tema.

| Sıralama | Oyuncular ve renk geçmişi |
|---|---|
| ![Sıralama](docs/siralama.png) | ![Oyuncular](docs/oyuncular.png) |

## Kurulum (Windows)

1. [Son sürüm sayfasından](https://github.com/etgazavalsiz/chesspresso-eslestirme/releases/latest) **`Chesspresso-Kurulum-x.y.z.exe`** dosyasını indirin.
2. Çift tıklayın. Kurulum birkaç saniye sürer; yönetici izni gerekmez.
3. Masaüstünde ve Başlat menüsünde **Chesspresso Eşleştirme** kısayolu oluşur, program açılır.

> **"Windows kişisel bilgisayarınızı korudu" uyarısı çıkarsa:** Program dijital olarak imzalanmadığı için Windows SmartScreen bu uyarıyı gösterir. **Ek bilgi → Yine de çalıştır** ile devam edebilirsiniz.

**Kaldırmak için:** Ayarlar → Uygulamalar → Yüklü uygulamalar → *Chesspresso Eşleştirme* → Kaldır.

Kurulum istemiyorsanız aynı sayfadaki **`Chesspresso-win32-x64-….zip`** dosyasını açıp içindeki `chesspresso.exe` ile taşınabilir olarak da çalıştırabilirsiniz.

## Kurulumsuz kullanım

Program tek bir dosyadan ibarettir: [`index.html`](index.html). Bu dosyayı indirip Chrome, Edge, Firefox veya Safari ile açmanız yeterlidir — macOS ve Linux dahil. İnternet bağlantısı gerekmez.

## Hızlı başlangıç

1. **Turnuva oluşturun** — Ad ve tur sayısı (oyuncu sayısı N ise en az log₂N tur önerilir; 16 oyuncu → 4–5 tur).
2. **Oyuncuları ekleyin** — Tek tek ya da Excel'den toplu yapıştırarak (`Ad Soyad, ELO, Kulüp`). Başlangıç sırası ELO'ya göre otomatik belirlenir.
3. **Turlar → "1. turu eşleştir"** — Oyuncu sayısı tekse bayı program seçer ve son masaya ekler.
4. **Sonuçları girin**, sonraki tura geçin. Sıralama ve averajlar anında güncellenir.
5. **PDF indir** ile eşleştirmeyi duvara asın, turnuva sonunda **Tüm rapor (PDF)** alın.

## Eşleştirme kuralları

Program FIDE'nin Hollanda (Dutch) sistemi kurallarını öncelik sırasına göre ağırlıklara çevirir ve Edmonds'un en büyük ağırlıklı eşleşme ("blossom") algoritmasıyla tüm olasılıklar arasından en iyi eşleştirmeyi tek seferde bulur; çıkmaza girmez.

1. **Tekrar yok:** İki oyuncu ikinci kez karşılaşmaz (hükmen maçlar oynanmamış sayılır).
2. **Renk:** Kimse aynı renkle üst üste üç kez oynamaz, beyaz–siyah farkı 2'yi geçmez.
3. **Bay:** En düşük puan grubunda, daha önce bay geçmemiş (ve hükmen kazanmamış) en alt sıradaki oyuncu bay geçer. Bay renk sayılmaz.
4. **Puan grupları:** Aynı puandakiler eşleşir; grup tek sayıysa en alttaki oyuncu bir alt gruba kayar. Aynı oyuncunun üst üste kaydırılmasından kaçınılır.
5. **Renk tercihi:** Herkes mümkün olduğunca renk değiştirir.
6. **Sıra:** Grubun üst yarısı alt yarısıyla eşleşir (8 kişilik grupta 1–5, 2–6, 3–7, 4–8).

**Renk önceliği** (Turnuva ayarları):
- **Dengeli (varsayılan):** Bir oyuncunun renk farkı 2'ye çıkacaksa (ör. 4 oyunda 3 beyaz), program onu yakın puanlı başka bir rakiple eşleştirir. Simülasyonlarda renk dengesizliğini belirgin şekilde azaltır.
- **FIDE:** Puan grupları her zaman renkten önce gelir.

> Not: Chesspresso FIDE kurallarını yakından izler ancak **FIDE onaylı bir eşleştirme motoru değildir**. Resmî ELO/UKD işlenecek turnuvalarda federasyonunuzun istediği yazılımı kullanın.

## Veriler ve yedekleme

Turnuvalar yalnızca sizin bilgisayarınızda saklanır; hiçbir yere gönderilmez.

- Masaüstü uygulamasında veriler kullanıcı klasörünüzde, HTML dosyasını tarayıcıda açtığınızda ise o tarayıcının içinde tutulur. İkisi birbirini görmez.
- **Turnuva ayarları → Yedek indir (.json)** ile yedek alın; başka bir bilgisayara veya uygulamaya **Yedekten yükle** ile taşıyın.

## Geliştirme

Uygulamanın tamamı [`index.html`](index.html) içindedir (eşleştirme motoru, PDF üretici ve arayüz; dış kütüphane yoktur). Masaüstü sürümü bu dosyayı [Electron](https://www.electronjs.org/) penceresinde açar.

```bash
npm install
npm start          # masaüstü uygulamasını geliştirme modunda açar
npm run make       # Windows kurulum dosyasını out/make/ altına üretir
```

Simgeyi yeniden üretmek için: `powershell -File build/make-icon.ps1`

## Teşekkür

En büyük ağırlıklı eşleşme algoritması, Joris van Rantwijk'in `mwmatching.py` uygulamasından JavaScript'e uyarlanmıştır.

## Lisans

[MIT](LICENSE) — özgürce kullanabilir, değiştirebilir ve paylaşabilirsiniz.
