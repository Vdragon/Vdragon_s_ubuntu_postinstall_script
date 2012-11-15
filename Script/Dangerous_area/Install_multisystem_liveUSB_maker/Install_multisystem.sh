
echo -e "
=======================================
${message_install_or_update} multisystem可開機USB隨身碟製作工具
======================================="
echo -e ${message_add_software_source}
${command_gain_privilege} apt-add-repository --yes "deb http://liveusb.info/multisystem/depot all main"
wget --output-document=- http://liveusb.info/multisystem/depot/multisystem.asc | \
${command_gain_privilege} apt-key add -
echo -e ${message_update_cache}
${command_gain_privilege} ${command_update_source_cache} >> update_cache.log
${command_gain_privilege} ${command_install_software} multisystem
#SUDO_USER 是空的沒有用
#sudo usermod --groups adm --append ${SUDO_USER}

