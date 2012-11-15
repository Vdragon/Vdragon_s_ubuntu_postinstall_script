#!/bin/bash
##上一句用來宣告執行 script 所使用的 shell 程式
##================================
##Shell script 名稱：Vdragons_Ubuntu_postinstall_script
##此 Shellscript 所適用的平台：Ubuntu 12.04LTS（部份適用於其他基於 Debian 的 Linux 散佈版本）
##智慧財產授權：GPL v3 or later
##傳回值：0-正常結束
##================================
echo -e "
================================
Ｖ字龍的 Ubuntu 安裝後預先設定 script 程式
開發者 | Developer
  Ｖ字龍(Vdragon)
已知問題 | Known Issues
  請至下列網址查看或回報
  https://github.com/Vdragon/Vdragon_s_ubuntu_postinstall_script/issues
官方網站 | Official Site
  https://github.com/Vdragon/Vdragon_s_ubuntu_postinstall_script
警告 | Warning
  本 script 程式將會修改您系統的軟體來源設定以及安裝軟體，可能會造成無法預知的問題，請自行承擔後果！
================================"
###### 環境設定 | Environment settings ######
## 設定環境變數 | Set environment variables
#sudo command settings
message_sudo_prompt_password="請輸入 %p 的密碼以獲取系統管理權限："
option_sudo_prompt_password="-p ${message_sudo_prompt_password}"
command_sudo_gain_privilege="sudo ${option_sudo_prompt_password}"

#apt-get command settings
option_apt_get_action_confirmation="--assume-yes --allow-unauthenticated"
command_apt_get_update_source_cache="apt-get update"
command_apt_get_install_software="apt-get ${option_apt_get_action_confirmation} install"
command_apt_get_upgrade_system="apt-get ${option_apt_get_action_confirmation}  upgrade"

#aptitude command settings
option_aptitude_action_confirmation="--assume-yes --allow-untrusted"
command_aptitude_update_source_cache="aptitude update"
command_aptitude_install_software="aptitude ${option_aptitude_action_confirmation} install"
command_aptitude_upgrade_system="aptitude ${option_aptitude_action_confirmation} safe-upgrade"

#apt-fast command settings
option_apt_fast_action_confirmation="--assume-yes"
command_apt_fast_update_source_cache="apt-fast update"
command_apt_fast_install_software="apt-fast ${option_apt_fast_action_confirmation} install"
command_apt_fast_upgrade_system="apt-fast ${option_apt_fast_action_confirmation} upgrade"

#add-apt-repository command settings
option_add_apt_repository_confirmation="--yes"
command_add_apt_repository_add_software_source="add-apt-repository ${option_add_apt_repository_confirmation}"

#廣域命令設定
#global command settings
#================================
#這是實際上安裝軟體時所用的命令
command_gain_privilege="${command_sudo_gain_privilege}"
command_add_software_source="${command_add_apt_repository_add_software_source}"
message_add_software_source="新增軟體來源中，請稍候…"
command_update_source_cache="${command_aptitude_update_source_cache}"
message_update_cache="更新軟體來源快取資料中，請稍候…"
command_install_software="${command_aptitude_install_software}"
command_upgrade_system="${command_aptitude_upgrade_system}"
message_install_or_update="安裝／升級"
###### 環境設定結束 | Environment settings ended ######

###### 安裝前階段 | Pre-install phase ######
##先取得超級管理員權限
#read -p "請輸入您的使用者帳號的密碼：" user_password
${command_gain_privilege} echo -e "成功取得超級使用者(superuser, root)權限。"

echo -e "
========================================
建立暫時存放本程序運行時所需檔案的目錄「Temp_folder_created_by_Vdragon_s_ubuntu_postinstall_script」，如果執行完不再需要請自行刪除。
======================================="
mkdir Temp_folder_created_by_Vdragon_s_ubuntu_postinstall_script
cd Temp_folder_created_by_Vdragon_s_ubuntu_postinstall_script

echo -e "
=======================================
安裝前軟體包裹管理系統檢查、系統更新
======================================="
#apt-get
  #check
    #check is a diagnostic tool; it updates the package cache and
    #checks for broken dependencies.
echo -e ${message_update_cache}
${command_gain_privilege} ${command_apt_get_update_source_cache} >> update_cache.log
${command_gain_privilege} apt-get --assume-yes --allow-unauthenticated --fix-broken install
${command_gain_privilege} ${command_apt_get_upgrade_system}

##檢查本script程式軟體相依性(software dependency)是否滿足，這樣Script才能正常運行。
##此區域不能使用廣域命令
echo -e "
=======================================
檢查並安裝運行本 script 程式所需要的軟體
======================================="
#安裝軟體來源的命令應該要放在最前面，以免其他軟體需要安裝到軟體來源
echo -e "
=======================================
確認 add-apt-repository 軟體來源設定程式是否已被安裝
======================================="
##http://www.google.com/url?sa=t&source=web&cd=4&ved=0CEUQFjAD&url=http%3A%2F%2Fkirby86a.pixnet.net%2Fblog%2Fpost%2F45530809-%25E5%25B8%25B8%25E8%25A6%258B%25E6%258C%2587%25E4%25BB%25A4add-apt-repository%25E5%25BE%259E%25E5%2593%25AA%25E4%25BE%2586%253F&ei=CxibTpf7OYj-mAXrn4yHAg&usg=AFQjCNHkSvl4vM86dSL55OiwTi0r_zw6sg&sig2=Icg7-HmgQdliEeYLk9T1MA
${command_gain_privilege} ${command_apt_get_install_software} python-software-properties

#先安裝localepurge，這樣才會受惠之後的安裝
echo -e "
=======================================
安裝 localepurge 無用語系資料自動清除工具
當進行 debconf 設定時建議選擇 en*語系以及您認識的語言的相關語系（例如zh*）
任何沒有選擇的語系的語系資料將被 localepurge 自動移除
======================================="
${command_gain_privilege} ${command_apt_get_install_software} localepurge

echo -e "
=======================================
確認 Aptitude 軟體包裹管理系統前端程式是否已被安裝
======================================="
${command_gain_privilege} ${command_apt_get_install_software} aptitude

echo -e "
=======================================
確認 Git 版本控制系統是否已被安裝
======================================="
echo -e ${message_add_software_source}
${command_gain_privilege} ${command_add_apt_repository_add_software_source} ppa:git-core/ppa
echo -e ${message_update_cache}
${command_gain_privilege} ${command_apt_get_update_source_cache} >> update_cache.log
${command_gain_privilege} ${command_apt_get_install_software} git

echo -e "
=======================================
${message_install_or_update} apt-fast 軟體包裹管理系統前端程式
======================================="
${command_gain_privilege} ${command_apt_get_install_software} axel aria2
echo -e ${message_add_software_source}
${command_gain_privilege} ${command_add_apt_repository_add_software_source} ppa:apt-fast/stable
echo -e ${message_update_cache}
${command_gain_privilege} ${command_apt_get_update_source_cache} >> update_cache.log
${command_gain_privilege} ${command_apt_get_install_software} apt-fast
###### 安裝前階段結束 | Pre-install phase ended ######

#=====需要新增軟體來源的軟體=====
echo -e "
=======================================
${message_install_or_update} Pidgin 即時通訊軟體
======================================="
echo -e ${message_add_software_source}
${command_gain_privilege} ${command_add_software_source} ppa:pidgin-developers/ppa
echo -e ${message_update_cache}
${command_gain_privilege} ${command_update_source_cache} >> update_cache.log
${command_gain_privilege} ${command_install_software} pidgin

echo -e "
=======================================
${message_install_or_update} Virtualbox 虛擬機器軟體
======================================="
read -p "請輸入您要加入「vboxusers」群組允許其使用VirtualBox USB裝置轉接功能的使用者帳號名稱：" vbox_user_name
echo -e ${message_add_software_source}
#加入Virtualbox的官方軟體來源
${command_gain_privilege} ${command_add_software_source} "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release --short --codename) contrib"
${command_gain_privilege} add-apt-repository --remove "deb-src http://download.virtualbox.org/virtualbox/debian $(lsb_release --short --codename) contrib" > /dev/null
wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc
${command_gain_privilege} apt-key add ./oracle_vbox.asc
echo -e ${message_update_cache}
${command_gain_privilege} ${command_update_source_cache} >> update_cache.log
#Ubuntu/Debian users might want to install the dkms package to ensure that the VirtualBox host kernel modules (vboxdrv, vboxnetflt and vboxnetadp) are properly updated if the linux kernel version changes during the next apt-get upgrade.
${command_gain_privilege} ${command_install_software} dkms
${command_gain_privilege} ${command_install_software} virtualbox-4.1
#add $user_name to vboxusers group
${command_gain_privilege} usermod --append --groups vboxusers $vbox_user_name

echo -e "
=======================================
${message_install_or_update} Boot-Repair 開機載入程式修復工具
======================================="
echo -e ${message_add_software_source}
${command_gain_privilege} ${command_add_software_source} ppa:yannubuntu/boot-repair
echo -e ${message_update_cache}
${command_gain_privilege} ${command_update_source_cache} >> update_cache.log
${command_gain_privilege} ${command_install_software} boot-repair

echo -e "
=======================================
${message_install_or_update} GNOME 3 桌面環境軟體系列
======================================="
echo -e ${message_add_software_source}
${command_gain_privilege} ${command_add_software_source} ppa:gnome3-team/gnome3
echo -e ${message_update_cache}
${command_gain_privilege} ${command_update_source_cache} >> update_cache.log
${command_gain_privilege} ${command_install_software} gnome

echo -e "
=======================================
${message_install_or_update} Google Chrome 網頁瀏覽器
======================================="
echo -e ${message_add_software_source}
#加入Google Chrome的官方軟體來源
${command_gain_privilege} ${command_add_software_source} "deb http://dl.google.com/linux/chrome/deb/ stable main"
${command_gain_privilege} add-apt-repository --remove "deb-src http://dl.google.com/linux/chrome/deb/ stable main" > /dev/null
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | \
${command_gain_privilege} apt-key add -
echo -e ${message_update_cache}
${command_gain_privilege} ${command_update_source_cache} >> update_cache.log
${command_gain_privilege} ${command_install_software} google-chrome-stable

echo -e "
=======================================
${message_install_or_update} 姬(H.I.M.E.)中文輸入法
======================================="
echo -e ${message_add_software_source}
#${command_gain_privilege} ${command_add_software_source} ppa:hime-team/hime
${command_gain_privilege} ${command_add_software_source} "deb http://debian.luna.com.tw/$(lsb_release --short --codename) ./"
echo -e ${message_update_cache}
${command_gain_privilege} ${command_update_source_cache} >> update_cache.log
${command_gain_privilege} ${command_install_software} hime
#設定HIME為預設的輸入法（執行命令使用者&root）
im-switch -s hime
${command_gain_privilege} im-switch -s hime
#將HIME加入Unity桌面環境通知列(notification bar)的白名單中
gsettings set com.canonical.Unity.Panel systray-whitelist "['hime']"
${command_gain_privilege} gsettings set com.canonical.Unity.Panel systray-whitelist "['hime']"
${command_gain_privilege} glib-compile-schemas /usr/share/glib-2.0/schemas

echo -e "
=======================================
移除 ibus 輸入法
======================================="
${command_gain_privilege} apt-get --assume-yes purge ibus ibus-chewing

echo -e "
=======================================
${message_install_or_update} VLC 影音播放軟體
======================================="
echo -e ${message_add_software_source}
${command_gain_privilege} ${command_add_software_source} ppa:videolan/stable-daily
echo -e ${message_update_cache}
${command_gain_privilege} ${command_update_source_cache} >> update_cache.log
${command_gain_privilege} ${command_install_software} vlc

echo -e "
=======================================
${message_install_or_update} LibreOffice 辦公室應用套裝軟體 3.5.x
======================================="
echo -e ${message_add_software_source}
${command_gain_privilege} ${command_add_software_source} ppa:libreoffice/libreoffice-3-5
echo -e ${message_update_cache}
${command_gain_privilege} ${command_update_source_cache} >> update_cache.log
${command_gain_privilege} ${command_install_software} libreoffice libreoffice-gnome libreoffice-kde

echo -e "
=======================================
${message_install_or_update} Grub Customizer Grub 開機載入程式設定工具
======================================="
echo -e ${message_add_software_source}
${command_gain_privilege} ${command_add_software_source} ppa:danielrichter2007/grub-customizer
echo -e ${message_update_cache}
${command_gain_privilege} ${command_update_source_cache} >> update_cache.log
${command_gain_privilege} ${command_install_software} grub-customizer

echo -e "
=======================================
${message_install_or_update} Wine Windows 平台程式相容層
======================================="
echo -e ${message_add_software_source}
${command_gain_privilege} ${command_add_software_source} ppa:ubuntu-wine/ppa
echo -e ${message_update_cache}
${command_gain_privilege} ${command_update_source_cache} >> update_cache.log
${command_gain_privilege} ${command_install_software} wine

echo -e "
=======================================
${message_install_or_update} JDownloader 檔案下載軟體
======================================="
echo -e ${message_add_software_source}
${command_gain_privilege} ${command_add_software_source} ppa:jd-team/jdownloader
echo -e ${message_update_cache}
${command_gain_privilege} ${command_update_source_cache} >> update_cache.log
${command_gain_privilege} ${command_install_software} jdownloader

echo -e "
=======================================
${message_install_or_update} K桌面環境(K Desktop Environment, KDE)軟體組合
======================================="
echo -e ${message_add_software_source}
${command_gain_privilege} ${command_add_software_source} ppa:kubuntu-ppa/ppa
echo -e ${message_update_cache}
${command_gain_privilege} ${command_update_source_cache} >> update_cache.log
${command_gain_privilege} ${command_install_software} kde-standard kdesudo kde-l10n-zhtw kdesdk-dolphin-plugins gtk2-engines-oxygen gtk3-engines-oxygen bluedevil kcron kde-config-gtk kde-config-tablet kde-config-telepathy-accounts kde-config-touchpad kdenetwork-filesharing system-config-printer-kde printer-applet

echo -e "
=======================================
${message_install_or_update} Dropbox 檔案同步軟體
======================================="
echo -e ${message_add_software_source}
${command_gain_privilege} ${command_add_software_source} "deb http://linux.dropbox.com/ubuntu $(lsb_release --short --codename) main"
${command_gain_privilege} add-apt-repository --remove "deb-src http://linux.dropbox.com/ubuntu $(lsb_release --short --codename) main" > /dev/null
${command_gain_privilege} apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E
echo -e ${message_update_cache}
${command_gain_privilege} ${command_update_source_cache} >> update_cache.log
${command_gain_privilege} ${command_install_software} dropbox python-gpgme 

echo -e "
=======================================
${message_install_or_update} DeaDBeeF 音樂播放軟體
======================================="
echo -e ${message_add_software_source}
${command_gain_privilege} ${command_add_software_source} ppa:alexey-smirnov/deadbeef
echo -e ${message_update_cache}
${command_gain_privilege} ${command_update_source_cache} >> update_cache.log
${command_gain_privilege} ${command_install_software} deadbeef

echo -e "
=======================================
${message_install_or_update} Ubuntu Tweak 系統調整工具
======================================="
echo -e ${message_add_software_source}
${command_gain_privilege} ${command_add_software_source} ppa:tualatrix/ppa
echo -e ${message_update_cache}
${command_gain_privilege} ${command_update_source_cache} >> update_cache.log
${command_gain_privilege} ${command_install_software} ubuntu-tweak

echo -e "
=======================================
${message_install_or_update} XBMC 影音播放軟體
======================================="
echo -e ${message_add_software_source}
${command_gain_privilege} ${command_add_software_source} ppa:team-xbmc/ppa
echo -e ${message_update_cache}
${command_gain_privilege} ${command_update_source_cache} >> update_cache.log
${command_gain_privilege} ${command_install_software} xbmc

#=====不需要新增軟體來源的軟體=====
echo -e "
=======================================
安裝 Synaptic 軟體包裹管理程式
======================================="
${command_gain_privilege} ${command_install_software} synaptic

echo -e "
=======================================
安裝 ubuntu 非自由軟體集合
含有大部份的影音編／解碼器、Adobe Flash等常用的非自由軟體
======================================="
${command_gain_privilege} ${command_install_software} ubuntu-restricted-extras

echo -e "
=======================================
安裝 Vim 文字編輯器
======================================="
${command_gain_privilege} ${command_install_software} vim

echo -e "
=======================================
安裝 htop 系統資源監視程式
======================================="
${command_gain_privilege} ${command_install_software} htop

echo -e "
=======================================
安裝 make-kpkg Linux 作業系統核心 Debian 軟體包裹製作工具
======================================="
${command_gain_privilege} ${command_install_software} kernel-package fakeroot

echo -e "
=======================================
安裝 bleachbit 檔案清理工具
======================================="
${command_gain_privilege} ${command_install_software} bleachbit

echo -e "
=======================================
安裝 ppa-purge PPA 還原程式
======================================="
${command_gain_privilege} ${command_install_software} ppa-purge

echo -e "
=======================================
安裝 powertop 電力消耗監視程式
======================================="
${command_gain_privilege} ${command_install_software} powertop

echo -e "
=======================================
安裝 Eclipse 整合式開發環境
======================================="
${command_gain_privilege} ${command_install_software} eclipse

echo -e "
=======================================
安裝 Eclipse CDT Plugin
======================================="
${command_gain_privilege} ${command_install_software} eclipse-cdt

echo -e "
=======================================
安裝 G++ C++toolchain
======================================="
${command_gain_privilege} ${command_install_software} g++

echo -e "
=======================================
安裝 valgrind 程式除錯工具
======================================="
${command_gain_privilege} ${command_install_software} valgrind

echo -e "
=======================================
安裝 p7zip 壓縮／封裝檔解壓縮程式以及 RAR 格式壓縮檔解壓縮支援
======================================="
${command_gain_privilege} ${command_install_software} p7zip-full p7zip-rar

echo -e "
=======================================
安裝 K3b 光碟燒錄程式
======================================="
${command_gain_privilege} ${command_install_software} k3b

echo -e "
=======================================
安裝 deborphan 孤立軟體包裹移除工具
======================================="
${command_gain_privilege} ${command_install_software} deborphan

echo -e "
=======================================
安裝 kfind 檔案搜索工具
======================================="
${command_gain_privilege} ${command_install_software} kfind

echo -e "
=======================================
安裝 Asunder CD ripper 音樂CD轉錄工具
======================================="
${command_gain_privilege} ${command_install_software} asunder

echo -e "
=======================================
安裝 MusicBrainz Picard 歌曲中介資料搜尋軟體
======================================="
${command_gain_privilege} ${command_install_software} picard

echo -e "
=======================================
安裝 Stellarium 星象模擬軟體
======================================="
${command_gain_privilege} ${command_install_software} stellarium

##後安裝階段
echo -e "
=======================================
安裝後系統更新
======================================="
${command_gain_privilege} ${command_upgrade_system}

##結束
cd ..
echo -e "
=======================================
本 Script 程式執行完畢。
如果暫時存放本 Script 程式運作所需檔案的目錄「Temp_folder_created_by_My_Ubuntu_preconfigure_script_sh」不再需要的話請自行刪除。
======================================="
exit 0
