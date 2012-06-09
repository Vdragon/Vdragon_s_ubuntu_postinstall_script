#!/bin/bash
##上一句用來宣告執行script所使用的shell

##Shell script名稱：Vdragons_Ubuntu_postinstall_script
##版本：列於下方
##Shell script範本版本：1.00(0)201110171310
##此Shellscript所適用的平台：Ubuntu 11.10（理論上就此script編輯當時一段時間前之Ubuntu的發行版皆適用）
##智慧財產授權：創用CC(BY-NC-SA)目前的最新版本
##傳回值：0-正常結束
##已知問題：
##	add-apt-repository的操作不乾淨...最好是改為手動設定/etc/apt/sources.list檔案
##修訂紀錄：
##

##show title
echo -e '
================================
Ubuntu安裝後預先設定script
作者：Ｖ字龍(Vdragon)
　電子郵件地址：pika1021@gmail.com
================================'


##先取得超級管理員權限
#read -p "請輸入您的使用者帳號的密碼：" user_password
echo -e "請輸入您的使用者帳號的密碼："
sudo echo -e "成功取得超級使用者(superuser, root)權限。"

echo -e '
========================================
建立暫時存放檔案的目錄"Temp_folder_created_by_My_Ubuntu_preconfigure_script_sh"，如果執行完沒有成功刪除請自行刪除。
======================================='
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
sudo apt-get update
sudo apt-get --assume-yes --allow-unauthenticated --fix-broken install
sudo apt-get --assume-yes --allow-unauthenticated upgrade

echo -e '
=======================================
確認add-apt-repository是某否已安裝
======================================='
##http://www.google.com/url?sa=t&source=web&cd=4&ved=0CEUQFjAD&url=http%3A%2F%2Fkirby86a.pixnet.net%2Fblog%2Fpost%2F45530809-%25E5%25B8%25B8%25E8%25A6%258B%25E6%258C%2587%25E4%25BB%25A4add-apt-repository%25E5%25BE%259E%25E5%2593%25AA%25E4%25BE%2586%253F&ei=CxibTpf7OYj-mAXrn4yHAg&usg=AFQjCNHkSvl4vM86dSL55OiwTi0r_zw6sg&sig2=Icg7-HmgQdliEeYLk9T1MA
sudo apt-get --assume-yes --allow-unauthenticated install python-software-properties

#echo -e '
#=======================================
#安裝Git版本控制系統以使用apt-fast
#======================================='
#mkdir apt-fast
#cd apt-fast
#sudo add-apt-repository --yes ppa:git-core/ppa
#sudo apt-get update
#sudo apt-get --assume-yes --allow-unauthenticated install git axel

echo -e '
=======================================
安裝Aptitude、Synaptic軟體包裹管理程式
======================================='
sudo apt-get --assume-yes --allow-unauthenticated install synaptic aptitude

echo -e '
=======================================
安裝ubuntu非自由軟體集合
含有大部份的影音編／解碼器、Adobe Flash等常用的非自由軟體
======================================='
sudo apt-get --assume-yes --allow-unauthenticated install ubuntu-restricted-extras

echo -e '
=======================================
安裝Vim文字編輯器
======================================='
sudo apt-get --assume-yes --allow-unauthenticated install vim

echo -e '
=======================================
安裝htop系統資源監視程式
======================================='
sudo apt-get --assume-yes --allow-unauthenticated install htop

echo -e '
=======================================
安裝localepurge語系資料清除工具
======================================='
sudo apt-get --assume-yes --allow-unauthenticated install localepurge

echo -e "
=======================================
安裝K桌面環境(K Desktop Environment)軟體系列
======================================="
sudo apt-get --assume-yes --allow-unauthenticated install kde-standard kdesudo kde-l10n-zhtw kdesdk-dolphin-plugins

echo -e '
=======================================
安裝 make-kpkg Linux Kernel軟體包裹製作工具
======================================='
sudo apt-get --assume-yes --allow-unauthenticated install kernel-package fakeroot

echo -e '
=======================================
安裝 bleachbit 檔案清理工具
======================================='
sudo apt-get --assume-yes --allow-unauthenticated install bleachbit

echo -e '
=======================================
安裝 ppa-purge PPA還原程式
======================================='
sudo apt-get --assume-yes --allow-unauthenticated install ppa-purge

echo -e '
=======================================
安裝 powertop 電力消耗監視程式
======================================='
sudo apt-get --assume-yes --allow-unauthenticated install powertop

#=====需要新增軟體來源的軟體=====
echo -e '
=======================================
安裝Pidgin即時通訊軟體
======================================='
sudo add-apt-repository --yes ppa:pidgin-developers/ppa
sudo apt-get --assume-yes --allow-unauthenticated install pidgin

echo -e "
=======================================
安裝Virtualbox虛擬機器軟體
======================================="
##設定環境變數
read -p "請輸入您的使用者帳號名稱：" user_name
#加入Virtualbox的官方軟體來源
sudo add-apt-repository --yes "deb http://download.virtualbox.org/virtualbox/debian `lsb_release --short --codename` contrib"
sudo add-apt-repository --remove "deb-src http://download.virtualbox.org/virtualbox/debian `lsb_release --short --codename` contrib" > /dev/null
wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc
sudo apt-key add ./oracle_vbox.asc
sudo apt-get update
#Ubuntu/Debian users might want to install the dkms package to ensure that the VirtualBox host kernel modules (vboxdrv, vboxnetflt and vboxnetadp) are properly updated if the linux kernel version changes during the next apt-get upgrade.
sudo apt-get --assume-yes --allow-unauthenticated install dkms
sudo apt-get --assume-yes --allow-unauthenticated install virtualbox-4.1
#add $user_name to vboxusers group
sudo usermod --append --groups vboxusers $user_name

echo -e "
=======================================
安裝 Unity 桌面環境
======================================="
sudo add-apt-repository --yes ppa:unity-team/ppa
sudo apt-get update
sudo apt-get --assume-yes --allow-unauthenticated install unity

echo -e "
=======================================
安裝 Boot-Repair 開機載入程式修復工具
======================================="
sudo add-apt-repository --yes ppa:yannubuntu/boot-repair
sudo apt-get update
sudo apt-get --assume-yes --allow-unauthenticated install boot-repair

echo -e "
=======================================
安裝GNOME 3桌面環境軟體系列
======================================="
sudo add-apt-repository --yes ppa:gnome3-team/gnome3
sudo apt-get update
sudo apt-get --assume-yes --allow-unauthenticated install gnome

echo -e "
=======================================
安裝Google Chrome網頁瀏覽器
======================================="
#加入Virtualbox的官方軟體來源
sudo add-apt-repository --yes "deb http://dl.google.com/linux/chrome/deb/ stable main"
sudo add-apt-repository --remove "deb-src http://dl.google.com/linux/chrome/deb/ stable main" > /dev/null
sudo apt-fast update
sudo apt-fast --assume-yes --allow-unauthenticated install google-chrome-stable

echo -e '
=======================================
安裝burg開機載入程式
======================================='
sudo add-apt-repository --yes ppa:n-muench/burg
sudo apt-get update
sudo apt-get --assume-yes --allow-unauthenticated install burg

echo -e '
=======================================
安裝軟體開發工具
內含：
  Git 版本控制系統
　Eclipse整合式開發環境
　Eclipse CDT plugin
　g++ C++ toolchain
======================================='
sudo add-apt-repository --yes ppa:git-core/ppa
sudo apt-get update
sudo apt-get --assume-yes --allow-unauthenticated install git eclipse eclipse-cdt g++

echo -e '
=======================================
安裝姬(H.I.M.E.)輸入法
======================================='
#sudo add-apt-repository --yes ppa:hime-team/hime
sudo add-apt-repository --yes "deb http://debian.luna.com.tw/`lsb_release --short --codename` ./"
sudo apt-get update
sudo apt-get --assume-yes --allow-unauthenticated install hime

echo -e '
=======================================
移除ibus輸入法
======================================='
sudo apt-get --assume-yes purge ibus ibus-chewing

echo -e '
=======================================
安裝VLC影音播放軟體
======================================='
sudo add-apt-repository --yes ppa:videolan/stable-daily
sudo apt-get update
sudo apt-get --assume-yes --allow-unauthenticated install vlc

echo -e '
=======================================
安裝LibreOffice 辦公室應用套裝軟體 3.5.x
======================================='
sudo add-apt-repository --yes ppa:libreoffice/libreoffice-3-5
sudo apt-get update
sudo apt-get --assume-yes --allow-unauthenticated install libreoffice libreoffice-gnome libreoffice-kde

echo -e '
=======================================
安裝Grub Customizer Grub開機載入程式設定工具
======================================='
sudo add-apt-repository --yes ppa:danielrichter2007/grub-customizer
sudo apt-get update
sudo apt-get --assume-yes --allow-unauthenticated install grub-customizer

echo -e '
=======================================
安裝Wine Windows平台程式相容層
======================================='
sudo add-apt-repository --yes ppa:ubuntu-wine/ppa
sudo apt-get update
sudo apt-get --assume-yes --allow-unauthenticated install wine

echo -e '
=======================================
安裝 Dropbox
======================================='
sudo add-apt-repository --yes "deb http://linux.dropbox.com/ubuntu `lsb_release --short --codename` main"
sudo add-apt-repository --remove "deb-src http://linux.dropbox.com/ubuntu `lsb_release --short --codename` main" > /dev/null
sudo apt-get update
sudo apt-get --assume-yes --allow-unauthenticated install dropbox

##後安裝階段
echo -e '
=======================================
安裝後系統更新
======================================='
sudo apt-get --assume-yes --allow-unauthenticated upgrade

echo -e "
=======================================
移除不再需要的套件
======================================="
sudo apt-get --assume-yes autoremove

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
批次指令執行完畢。
如果暫時存放檔案的目錄「Temp_folder_created_by_My_Ubuntu_preconfigure_script_sh」還存在於工作目錄的話請自行刪除。
======================================='
exit 0

