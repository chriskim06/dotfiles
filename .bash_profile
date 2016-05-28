#
# .bash_profile
#

# Load .profile
if [[ -f $HOME/.profile ]]; then
    source $HOME/.profile
fi

# Load .bashrc
if [[ -f $HOME/.bashrc ]]; then
    source $HOME/.bashrc
fi

