// Chesspresso Eşleştirme — masaüstü kabuğu (Electron).
// Uygulamanın tamamı index.html içindedir; bu dosya yalnızca onu bir pencerede açar.
const { app, BrowserWindow, Menu, shell } = require('electron');
const path = require('path');

// Windows kurulumu/kaldırması sırasında masaüstü ve Başlat menüsü kısayollarını oluşturur.
if (require('electron-squirrel-startup')) app.quit();

let win = null;

function createWindow() {
  win = new BrowserWindow({
    width: 1280,
    height: 860,
    minWidth: 720,
    minHeight: 520,
    title: 'Chesspresso Eşleştirme',
    icon: path.join(__dirname, 'build', 'icon.png'),
    backgroundColor: '#f4f3ef',
    autoHideMenuBar: true,
    webPreferences: { contextIsolation: true, sandbox: true },
  });
  win.loadFile(path.join(__dirname, 'index.html'));
  // Dış bağlantılar varsayılan tarayıcıda açılır.
  win.webContents.setWindowOpenHandler(({ url }) => {
    if (/^https?:/i.test(url)) shell.openExternal(url);
    return { action: 'deny' };
  });
  win.on('closed', () => { win = null; });
}

const menu = Menu.buildFromTemplate([
  {
    label: 'Dosya',
    submenu: [
      { label: 'Yazdır…', accelerator: 'CmdOrCtrl+P', click: () => win && win.webContents.print() },
      { type: 'separator' },
      { label: 'Çıkış', role: 'quit' },
    ],
  },
  {
    label: 'Görünüm',
    submenu: [
      { label: 'Yenile', role: 'reload' },
      { type: 'separator' },
      { label: 'Yakınlaştır', role: 'zoomIn', accelerator: 'CmdOrCtrl+=' },
      { label: 'Uzaklaştır', role: 'zoomOut' },
      { label: 'Gerçek boyut', role: 'resetZoom' },
      { type: 'separator' },
      { label: 'Tam ekran', role: 'togglefullscreen' },
    ],
  },
  {
    label: 'Yardım',
    submenu: [
      { label: 'Proje sayfası (GitHub)', click: () => shell.openExternal('https://github.com/etgazavalsiz/chesspresso-eslestirme') },
      { label: `Sürüm ${app.getVersion()}`, enabled: false },
    ],
  },
]);

// Aynı anda tek pencere: ikinci kez açılırsa mevcut pencere öne gelir.
if (!app.requestSingleInstanceLock()) {
  app.quit();
} else {
  app.on('second-instance', () => {
    if (!win) return;
    if (win.isMinimized()) win.restore();
    win.focus();
  });
  app.whenReady().then(() => {
    Menu.setApplicationMenu(menu);
    createWindow();
  });
  app.on('window-all-closed', () => app.quit());
}
