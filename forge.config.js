// Windows kurulum dosyasını üretir: npm run make
// Çıktı: out/make/squirrel.windows/x64/Chesspresso-Kurulum-<sürüm>.exe
const { version } = require('./package.json');

module.exports = {
  packagerConfig: {
    name: 'Chesspresso',
    executableName: 'chesspresso',
    icon: 'build/icon',
    asar: true,
    appCopyright: 'MIT Lisansı — github.com/etgazavalsiz/chesspresso-eslestirme',
    win32metadata: {
      CompanyName: 'Chesspresso',
      FileDescription: 'Chesspresso Eşleştirme',
      ProductName: 'Chesspresso Eşleştirme',
    },
    // Paketlenecek dosyalar: index.html, main.js, simgeler ve bağımlılıklar
    ignore: [/^\/docs/, /^\/out/, /^\/build\/make-icon\.ps1$/, /\.md$/, /^\/LICENSE$/, /^\/\.git/],
  },
  makers: [
    {
      name: '@electron-forge/maker-squirrel',
      config: {
        name: 'chesspresso',
        title: 'Chesspresso Eşleştirme',
        authors: 'etgazavalsiz',
        description: 'İsviçre sistemi satranç turnuvaları için eşleştirme ve sıralama programı',
        setupExe: `Chesspresso-Kurulum-${version}.exe`,
        setupIcon: 'build/icon.ico',
        iconUrl: 'https://raw.githubusercontent.com/etgazavalsiz/chesspresso-eslestirme/main/build/icon.ico',
        noMsi: true,
      },
    },
    { name: '@electron-forge/maker-zip', platforms: ['win32'] },
  ],
};
