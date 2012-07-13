Ｖ字龍的Ubuntu安裝後預先設定script程式
開發者 | Developer
  Ｖ字龍(Vdragon)
採用的授權條款 | Used License
  GPL v3 or later
已知問題 | Known Issues
  請至下列網址查看或回報
  https://github.com/Vdragon/Vdragon_s_ubuntu_postinstall_script/issues
官方網站 | Official Site
  https://github.com/Vdragon/Vdragon_s_ubuntu_postinstall_script
適用的系統 | System Supported
  Tested in ubuntu 12.04LTS
  Should partially supported in late versions of ubuntu
警告 | Warning
  本script程式將會修改您系統的軟體倉庫設定以及安裝軟體，可能會造成無法預知的問題，請自行承擔後果！
已知問題 | Known Issues
　* 目前無法選擇哪些項目要安裝、那些不要
　* Ubuntu 10.04LTS 的add-apt-repository程式無--yes選項，將其移除即可。
使用方式 | Usage
  圖形介面shell下的操作方式
    點擊專案網頁中的「ZIP」按鈕下載原始程式碼的ZIP壓縮封裝檔
    解壓縮下載下來的ZIP壓縮封裝檔於您具有寫入權限的目錄下
    開啟任一終端機模擬程式（如GNOME終端機(gnome-terminal)或Konsole終端機模擬程式(konsole)並切換當前工作目錄(current working directory)至原始程式碼的根目錄下（其中有Script目錄與README.txt等檔案）
    執行「bash Script/Vdragon_s_ubuntu_postinstall.sh」依照提示的訊息輸入對應的資料
  文字介面shell下的操作方式
    切換目錄至您具有寫入權限的目錄下
    確定您是否有安裝 Git版本控制系統 相關程式
      於ubuntu中可使用「sudo apt-get install git」命令安裝
    執行「git clone --branch stable https://github.com/Vdragon/Vdragon_s_ubuntu_postinstall_script.git 」
    執行「cd Vdragon_s_ubuntu_postinstall_script/」
    執行「bash Script/Vdragon_s_ubuntu_postinstall.sh」依照提示的訊息輸入對應的資料
於終端機（或終端機模擬程式）下切換工作目錄到可寫入的目錄下，以下列命令執行script
    bash 「Vdragon_s_ubuntu_postinstall.sh的路徑」
軟體依賴性 | Software Dependency
  Advanced Packaging Tool(APT)軟體包裹管理系統工具
  （script程式會嘗試自行安裝）python-software-properties軟體包裹
安裝的軟體 | Software Installation
  =====ubuntu官方軟體倉庫的版本=====
  Aptitude、Synaptic軟體包裹管理程式
  ubuntu非自由軟體集合
  Vim文字編輯器
  htop系統資源監視程式
  localepurge語系資料自動清除工具
  K桌面環境(K Desktop Environment)軟體組合
  make-kpkg Linux 作業系統核心軟體包裹製作工具
  bleachbit檔案清理工具
  ppa-purge PPA還原程式
  powertop 電力消耗監視程式
  Eclipse整合式開發環境
  Eclipse CDT plugin
  g++ C++ toolchain
  valgrind 程式除錯工具
  p7zip壓縮／封裝檔解壓縮程式以及RAR格式壓縮檔解壓縮支援
  K3b光碟燒錄程式
  deborphan孤立軟體包裹移除工具

  =====官方軟體來源的版本=====
  Pidgin即時通訊軟體
  Virtualbox虛擬機器軟體
  Unity 桌面環境
  Boot-Repair 開機載入程式修復工具
  GNOME 3桌面環境軟體系列
  Google Chrome網頁瀏覽器
  burg開機載入程式
  Git 版本控制系統
  姬(H.I.M.E.)中文輸入法（採用非官方(?)Tetralet的軟體來源）
  VLC影音播放軟體
  LibreOffice 辦公室應用套裝軟體 3.5.x
  Grub Customizer Grub開機載入程式設定工具
  Wine Windows平台程式相容層
  Dropbox檔案同步軟體

移除的軟體 | Software Removal
　ibus輸入法