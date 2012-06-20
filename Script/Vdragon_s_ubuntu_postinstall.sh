#!/bin/bash
##上一句用來宣告執行script所使用的shell

##Shell script名稱：Vdragons_Ubuntu_postinstall_script
##此Shellscript所適用的平台：Ubuntu 12.04LTS（理論上就此script編輯當時一段時間前之Ubuntu的發行版皆適用）
##智慧財產授權：創用CC(BY-NC-SA)目前的最新版本
##傳回值：0-正常結束
echo -e '
================================
Ubuntu安裝後預先設定script
開發者 | Developer
  Ｖ字龍(Vdragon)
已知問題 | Known Issues
  請至下列網址查看或回報
  https://github.com/Vdragon/Vdragon_s_ubuntu_postinstall_script/issues
官方網站 | Official Site
  https://github.com/Vdragon/Vdragon_s_ubuntu_postinstall_script
警告 | Warning
  本命令集合將會修改您系統的軟體倉庫設定以及安裝軟體，可能會造成無法預知的問題，請自行承擔後果！
================================'

#訊息
prompt_password="-p 請輸入%p的密碼："
message_add_source="新增軟體來源中，請稍候…"
message_update_cache="更新軟體來源快取資料中，請稍候…"

##先取得超級管理員權限
#read -p "請輸入您的使用者帳號的密碼：" user_password
sudo ${prompt_password} echo -e "成功取得超級使用者(superuser, root)權限。"

echo -e '
========================================
建立暫時存放檔案的目錄"Temp_folder_created_by_My_Ubuntu_preconfigure_script_sh"，如果執行完沒有成功刪除請自行刪除。
======================================='
rm --recursive --force Temp_folder_created_by_My_Ubuntu_preconfigure_script_sh 2>/dev/null
mkdir ./Temp_folder_created_by_My_Ubuntu_preconfigure_script_sh
cd ./Temp_folder_created_by_My_Ubuntu_preconfigure_script_sh

echo -e '
=======================================
安裝前軟體包裹管理系統檢查、系統更新
======================================='
#apt-get
  #check
    #check is a diagnostic tool; it updates the package cache and
    #checks for broken dependencies.
echo -e ${message_update_cache}
sudo ${prompt_password} apt-get update >> update_cache.log
sudo ${prompt_password} apt-get --assume-yes --allow-unauthenticated --fix-broken install
sudo ${prompt_password} apt-get --assume-yes --allow-unauthenticated upgrade

#echo -e '
#=======================================
#安裝Git版本控制系統以使用apt-fast
#======================================='
#mkdir apt-fast
#cd apt-fast
#sudo ${prompt_password} add-apt-repository --yes ppa:git-core/ppa
#sudo ${prompt_password} apt-get update
#sudo ${prompt_password} apt-get --assume-yes --allow-unauthenticated install git axel

#先安裝localepurge，這樣才會受惠之後的安裝
echo -e '
=======================================
安裝 localepurge語系資料自動清除工具
當進行 debconf 設定時建議選擇 en*語系以及您認識的語言的相關語系（例如zh*）
任何沒有選擇的語系的語系資料將被 localepurge 自動移除
======================================='
sudo ${prompt_password} apt-get --assume-yes --allow-unauthenticated install localepurge

#=====需要新增軟體來源的軟體=====
echo -e '
=======================================
確認add-apt-repository是否已安裝
======================================='
##http://www.google.com/url?sa=t&source=web&cd=4&ved=0CEUQFjAD&url=http%3A%2F%2Fkirby86a.pixnet.net%2Fblog%2Fpost%2F45530809-%25E5%25B8%25B8%25E8%25A6%258B%25E6%258C%2587%25E4%25BB%25A4add-apt-repository%25E5%25BE%259E%25E5%2593%25AA%25E4%25BE%2586%253F&ei=CxibTpf7OYj-mAXrn4yHAg&usg=AFQjCNHkSvl4vM86dSL55OiwTi0r_zw6sg&sig2=Icg7-HmgQdliEeYLk9T1MA
sudo ${prompt_password} apt-get --assume-yes --allow-unauthenticated install python-software-properties

echo -e '
=======================================
安裝Pidgin即時通訊軟體
======================================='
echo -e ${message_add_source}
sudo ${prompt_password} add-apt-repository --yes ppa:pidgin-developers/ppa
echo -e ${message_update_cache}
sudo ${prompt_password} apt-get update >> update_cache.log
sudo ${prompt_password} apt-get --assume-yes --allow-unauthenticated install pidgin

echo -e "
=======================================
安裝Virtualbox虛擬機器軟體
======================================="
read -p "請輸入您要加入「vboxusers」群組允許其使用VirtualBox USB裝置轉接功能的使用者帳號名稱：" vbox_user_name
echo -e ${message_add_source}
#加入Virtualbox的官方軟體來源
sudo ${prompt_password} add-apt-repository --yes "deb http://download.virtualbox.org/virtualbox/debian `lsb_release --short --codename` contrib"
sudo ${prompt_password} add-apt-repository --remove "deb-src http://download.virtualbox.org/virtualbox/debian `lsb_release --short --codename` contrib" > /dev/null
wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc
sudo ${prompt_password} apt-key add ./oracle_vbox.asc
echo -e ${message_update_cache}
sudo ${prompt_password} apt-get update >> update_cache.log
#Ubuntu/Debian users might want to install the dkms package to ensure that the VirtualBox host kernel modules (vboxdrv, vboxnetflt and vboxnetadp) are properly updated if the linux kernel version changes during the next apt-get upgrade.
sudo ${prompt_password} apt-get --assume-yes --allow-unauthenticated install dkms
sudo ${prompt_password} apt-get --assume-yes --allow-unauthenticated install virtualbox-4.1
#add $user_name to vboxusers group
sudo ${prompt_password} usermod --append --groups vboxusers $vbox_user_name

echo -e "
=======================================
安裝 Unity 桌面環境
======================================="
echo -e ${message_add_source}
sudo ${prompt_password} add-apt-repository --yes ppa:unity-team/ppa
echo -e ${message_update_cache}
sudo ${prompt_password} apt-get update >> update_cache.log
sudo ${prompt_password} apt-get --assume-yes --allow-unauthenticated install unity

echo -e "
=======================================
安裝 Boot-Repair 開機載入程式修復工具
======================================="
echo -e ${message_add_source}
sudo ${prompt_password} add-apt-repository --yes ppa:yannubuntu/boot-repair
echo -e ${message_update_cache}
sudo ${prompt_password} apt-get update >> update_cache.log
sudo ${prompt_password} apt-get --assume-yes --allow-unauthenticated install boot-repair

echo -e "
=======================================
安裝GNOME 3桌面環境軟體系列
======================================="
echo -e ${message_add_source}
sudo ${prompt_password} add-apt-repository --yes ppa:gnome3-team/gnome3
echo -e ${message_update_cache}
sudo ${prompt_password} apt-get update >> update_cache.log
sudo ${prompt_password} apt-get --assume-yes --allow-unauthenticated install gnome

echo -e "
=======================================
安裝Google Chrome網頁瀏覽器
======================================="
echo -e ${message_add_source}
#加入Google Chrome的官方軟體來源
sudo ${prompt_password} add-apt-repository --yes "deb http://dl.google.com/linux/chrome/deb/ stable main"
sudo ${prompt_password} add-apt-repository --remove "deb-src http://dl.google.com/linux/chrome/deb/ stable main" > /dev/null
echo -e ${message_update_cache}
sudo ${prompt_password} apt-get update >> update_cache.log
sudo ${prompt_password} apt-get --assume-yes --allow-unauthenticated install google-chrome-stable

echo -e '
=======================================
安裝burg開機載入程式
======================================='
echo -e ${message_add_source}
sudo ${prompt_password} add-apt-repository --yes ppa:n-muench/burg
echo -e ${message_update_cache}
sudo ${prompt_password} apt-get update >> update_cache.log
sudo ${prompt_password} apt-get --assume-yes --allow-unauthenticated install burg

echo -e '
=======================================
安裝Git 版本控制系統
======================================='
echo -e ${message_add_source}
sudo ${prompt_password} add-apt-repository --yes ppa:git-core/ppa
echo -e ${message_update_cache}
sudo ${prompt_password} apt-get update >> update_cache.log
sudo ${prompt_password} apt-get --assume-yes --allow-unauthenticated install git

echo -e '
=======================================
安裝姬(H.I.M.E.)中文輸入法
======================================='
echo -e ${message_add_source}
#sudo ${prompt_password} add-apt-repository --yes ppa:hime-team/hime
sudo ${prompt_password} add-apt-repository --yes "deb http://debian.luna.com.tw/`lsb_release --short --codename` ./"
echo -e ${message_update_cache}
sudo ${prompt_password} apt-get update >> update_cache.log
sudo ${prompt_password} apt-get --assume-yes --allow-unauthenticated install hime
im-switch -s hime

echo -e '
=======================================
移除ibus輸入法
======================================='
sudo ${prompt_password} apt-get --assume-yes purge ibus ibus-chewing

echo -e '
=======================================
安裝VLC影音播放軟體
======================================='
echo -e ${message_add_source}
sudo ${prompt_password} add-apt-repository --yes ppa:videolan/stable-daily
echo -e ${message_update_cache}
sudo ${prompt_password} apt-get update >> update_cache.log
sudo ${prompt_password} apt-get --assume-yes --allow-unauthenticated install vlc

echo -e '
=======================================
安裝LibreOffice 辦公室應用套裝軟體 3.5.x
======================================='
echo -e ${message_add_source}
sudo ${prompt_password} add-apt-repository --yes ppa:libreoffice/libreoffice-3-5
echo -e ${message_update_cache}
sudo ${prompt_password} apt-get update >> update_cache.log
sudo ${prompt_password} apt-get --assume-yes --allow-unauthenticated install libreoffice libreoffice-gnome libreoffice-kde

echo -e '
=======================================
安裝Grub Customizer Grub開機載入程式設定工具
======================================='
echo -e ${message_add_source}
sudo ${prompt_password} add-apt-repository --yes ppa:danielrichter2007/grub-customizer
echo -e ${message_update_cache}
sudo ${prompt_password} apt-get update >> update_cache.log
sudo ${prompt_password} apt-get --assume-yes --allow-unauthenticated install grub-customizer

echo -e '
=======================================
安裝Wine Windows平台程式相容層
======================================='
echo -e ${message_add_source}
sudo ${prompt_password} add-apt-repository --yes ppa:ubuntu-wine/ppa
echo -e ${message_update_cache}
sudo ${prompt_password} apt-get update >> update_cache.log
sudo ${prompt_password} apt-get --assume-yes --allow-unauthenticated install wine

echo -e '
=======================================
JDownloader 檔案下載軟體
======================================='
echo -e ${message_add_source}
sudo ${prompt_password} add-apt-repository --yes ppa:jd-team/jdownloader
echo -e ${message_update_cache}
sudo ${prompt_password} apt-get update >> update_cache.log
sudo ${prompt_password} apt-get --assume-yes --allow-unauthenticated install jdownloader

#=====不需要新增軟體來源的軟體=====
echo -e '
=======================================
安裝 Aptitude、Synaptic軟體包裹管理程式
======================================='
sudo ${prompt_password} apt-get --assume-yes --allow-unauthenticated install synaptic aptitude

echo -e '
=======================================
安裝 ubuntu非自由軟體集合
含有大部份的影音編／解碼器、Adobe Flash等常用的非自由軟體
======================================='
sudo ${prompt_password} apt-get --assume-yes --allow-unauthenticated install ubuntu-restricted-extras

echo -e '
=======================================
安裝 Vim文字編輯器
======================================='
sudo ${prompt_password} apt-get --assume-yes --allow-unauthenticated install vim

echo -e '
=======================================
安裝 htop系統資源監視程式
======================================='
sudo ${prompt_password} apt-get --assume-yes --allow-unauthenticated install htop

echo -e "
=======================================
安裝 K桌面環境(K Desktop Environment)軟體組合
======================================="
sudo ${prompt_password} apt-get --assume-yes --allow-unauthenticated install kde-standard kdesudo kde-l10n-zhtw kdesdk-dolphin-plugins gtk2-engines-oxygen gtk3-engines-oxygen

echo -e '
=======================================
安裝 make-kpkg Linux 作業系統核心軟體包裹製作工具
======================================='
sudo ${prompt_password} apt-get --assume-yes --allow-unauthenticated install kernel-package fakeroot

echo -e '
=======================================
安裝 bleachbit 檔案清理工具
======================================='
sudo ${prompt_password} apt-get --assume-yes --allow-unauthenticated install bleachbit

echo -e '
=======================================
安裝 ppa-purge PPA還原程式
======================================='
sudo ${prompt_password} apt-get --assume-yes --allow-unauthenticated install ppa-purge

echo -e '
=======================================
安裝 powertop 電力消耗監視程式
======================================='
sudo ${prompt_password} apt-get --assume-yes --allow-unauthenticated install powertop

echo -e '
=======================================
安裝 Eclipse整合式開發環境
======================================='
sudo ${prompt_password} apt-get --assume-yes --allow-unauthenticated install eclipse

echo -e '
=======================================
安裝 Eclipse CDT Plugin
======================================='
sudo ${prompt_password} apt-get --assume-yes --allow-unauthenticated install eclipse-cdt

echo -e '
=======================================
安裝 G++ C++toolchain
======================================='
sudo ${prompt_password} apt-get --assume-yes --allow-unauthenticated install g++

echo -e '
=======================================
安裝 valgrind 程式除錯工具
======================================='
sudo ${prompt_password} apt-get --assume-yes --allow-unauthenticated install valgrind

echo -e '
=======================================
安裝 p7zip壓縮／封裝檔解壓縮程式以及RAR格式壓縮檔解壓縮支援
======================================='
sudo ${prompt_password} apt-get --assume-yes --allow-unauthenticated install p7zip-full p7zip-rar

echo -e '
=======================================
安裝 K3b光碟燒錄程式
======================================='
sudo ${prompt_password} apt-get --assume-yes --allow-unauthenticated install k3b

echo -e '
=======================================
安裝 Dropbox檔案同步軟體
======================================='
sudo ${prompt_password} apt-get --assume-yes --allow-unauthenticated install dropbox

##後安裝階段
echo -e '
=======================================
安裝後系統更新
======================================='
sudo ${prompt_password} apt-get --assume-yes --allow-unauthenticated upgrade

#刪除script暫時存放檔案的目錄
echo -e '
=======================================
刪除script暫時存放檔案的目錄
"./Temp_folder_created_by_My_Ubuntu_preconfigure_script_sh"
======================================='
cd ..
rm --force --recursive ./Temp_folder_created_by_My_Ubuntu_preconfigure_script_sh

##結束
echo -e '
=======================================
批次命令執行完畢。
如果暫時存放檔案的目錄「Temp_folder_created_by_My_Ubuntu_preconfigure_script_sh」還存在於工作目錄的話請自行刪除。
======================================='
exit 0
