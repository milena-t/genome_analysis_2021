# .bash_profile, Uppmax user login script

# modules are used to manage user environment and software packages
if [ -f /etc/profile.modules ]
then
	. /etc/profile.modules
# load a default environment
#	module load sge 
# PGI compilers
#	module load pgi 
fi

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

export PATH=$HOME/bin:$PATH
