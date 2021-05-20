# RA $HOME/.cshrc, user startup script for all csh's
# this is run after the system wide /etc/csh.cshrc
# 
echo "HOME/.cshrc"

# Modules, activate the module command
if ($?tcsh) then
        set modules_shell="tcsh"
else
        set modules_shell="csh"
endif
alias module 'eval `/usr/local/Modules/$MODULE_VERSION/bin/modulecmd '$modules_shell '\!*`'

setenv PATH "$HOME/bin:${PATH}"

