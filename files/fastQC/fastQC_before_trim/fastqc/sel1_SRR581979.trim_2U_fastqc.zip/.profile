# .profile, Uppmax user login script

# modules are used to manage user environment and software packages
if [ -f /etc/profile.modules ]
then
	. /etc/profile.modules
# load a default environment
#	module load sge 
# PGI compilers
#	module load pgi 
fi


PATH=$HOME/bin:$PATH

export PATH
