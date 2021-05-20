# RA $HOME/.login, user startup script for login csh's
# this is run after the system wide /etc/csh.login
# 

if ( -e /etc/csh.modules ) then
	source /etc/csh.modules
# load a default environment
#	module load sge 
# PGI compilers
#	module load pgi 
endif
