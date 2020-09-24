[ -e /tmp/.failsafe ] && export FAILSAFE=1

[ -f /etc/banner ] && cat /etc/banner
[ -n "$FAILSAFE" ] && cat /etc/banner.failsafe

fgrep -sq '/ overlay ro,' /proc/mounts && {
	echo 'Your JFFS2-partition seems full and overlayfs is mounted read-only.'
	echo 'Please try to remove files from /overlay/upper/... and reboot!'
}

export PATH="%PATH%"
export HOME=$(grep -e "^${USER:-root}:" /etc/passwd | cut -d ":" -f 6)
export HOME=${HOME:-/root}
export LANG='en_US.UTF-8'
export PS1='[\[\033[35;1m\]\u\[\033[0m\]@\[\033[31;1m\]\h\[\033\[0m\]:\[\033[32;1m\]$PWD\[\033[0m\]]\$'
export ENV=/etc/shinit

case "$TERM" in
	xterm*|rxvt*)
		export PS1='\[\e]0;\u@\h: \w\a\]'$PS1
		;;
esac

[ -n "$FAILSAFE" ] || {
	for FILE in /etc/profile.d/*.sh; do
		[ -e "$FILE" ] && . "$FILE"
	done
	unset FILE
}

if ( grep -qs '^root::' /etc/shadow && \
     [ -z "$FAILSAFE" ] )
then
cat << EOF
=== WARNING! =====================================
There is no root password defined on this device!
Use the "passwd" command to set up a new password
in order to prevent unauthorized SSH logins.
--------------------------------------------------
EOF
fi
