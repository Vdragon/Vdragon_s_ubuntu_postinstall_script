
echo -e "
=======================================
${message_install_or_update} burg開機載入程式
======================================="
echo -e ${message_add_software_source}
${command_gain_privilege} ${command_add_software_source} ppa:n-muench/burg
echo -e ${message_update_cache}
${command_gain_privilege} ${command_update_source_cache} >> update_cache.log
${command_gain_privilege} ${command_install_software} burg

