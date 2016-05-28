#
# .bash_profile
#

# Add to the PATH variable
export PATH=$PATH:~/bin

# Load .profile
if [ -f ~/.profile ]; then
    source ~/.profile
fi

# Load .bashrc
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

