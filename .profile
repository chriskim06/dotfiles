#
# .profile
#

# Environment variables
export JAVA_HOME=`/usr/libexec/java_home`

# Allow git completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
    source `brew --prefix`/etc/bash_completion
fi
