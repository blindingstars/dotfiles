# Color and prompt symbol customizations of honukai (oskarkrawczyk/honukai-iterm-zsh)
# A few additional modifications from Nattesferd (DiegoVicen/nattesferd-zsh)
# Honukai is based on the great ys theme (http://ysmood.org/wp/2013/03/my-ys-terminal-theme/)

# Machine name

typeset -A host_repr

# This is the HOSTS dictionary. Add new entries following this format:
#           'real-name' "Name To Display"
host_repr=( 'Hummingbird.local' "Hummingbird"
            'Hummingbird.attlocal.net' "Hummingbird"
            'Heron.local' "Heron"
            'Heron.attlocal.net' "Heron"
            'Stephys-MBP.attlocal.net' "Heron"
            )

typeset -A user_repr

# This is the USERS dictionary. Add new entries following this format:
#           'real-name' "Name To Display"
# user_repr=( )

# Directory info.
local current_dir='$(shortpwd)'
#If you want the long version, uncomment this line and comment the one above
local current_dir='${PWD/#$HOME/~}'
shortpwd (){
    # This code is based in this answer of StackOverflow:
    # http://stackoverflow.com/a/2951707
    begin="" # The unshortened beginning of the path.
    shortbegin="" # The shortened beginning of the path.
    current="" # The section of the path we're currently working on.
    strend="${2:-$(pwd)}/" # The unmodified rest of the path.

    if [[ "$strend" =~ "$HOME" ]]; then
        INHOME=1
        strend="${strend#$HOME}" #strip /home/username from start of string
        begin="$HOME"      #start expansion from the right spot
    else
        INHOME=0
    fi

    strend="${strend#/}" # Strip the first /
    shortenedpath="$strend" # The whole path, to check the length.
    maxlength="${1:-0}"

    # setopt nullglob && NGV="-s" || NGV="-u" # Store the value for later.
    # setopt nullglob    # Without this, anything that doesn't exist in the filesystem turns into */*/*/...

    while [[ "$strend" ]] && (( ${#shortenedpath} > maxlength ))
    do
        current="${strend%%/*}" # everything before the first /
        strend="${strend#*/}"    # everything after the first /

        if [ "$strend" = "" ]; then
            break # Stop shortening if it's the last directory
        fi

        short="$current"

        for ((i=${#current}-2; i>=0; i--)); do
            subcurrent="${current:0:$i}"
            matching=("$begin/$subcurrent"*) # All files that start with $subcurrent.
            (( ${#matching[*]} != 1 )) && break # Stop shortening
            short="$subcurrent"
        done

        #advance
        begin="$begin/$current"
        shortbegin="$shortbegin/$short"
        shortenedpath="$shortbegin/$strend"
    done

    shortenedpath="${shortenedpath%/}" # strip trailing /
    shortenedpath="${shortenedpath#/}" # strip leading /

    if [ $INHOME -eq 1 ]; then
        echo "~/$shortenedpath" #make sure it starts with ~/
    else
        echo "/$shortenedpath" # Make sure it starts with /
    fi

    # setopt "$NGV" nullglob # Reset nullglob in case this is being used as a function.
}

# VCS
YS_VCS_PROMPT_PREFIX1=" %{$fg[white]%}on%{$reset_color%} "
YS_VCS_PROMPT_PREFIX2=":%{$fg[cyan]%}"
YS_VCS_PROMPT_SUFFIX="%{$reset_color%}"
YS_VCS_PROMPT_DIRTY=" %{$fg[red]%}●"
YS_VCS_PROMPT_CLEAN=" %{$fg[green]%}●"

# Git info.
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="${YS_VCS_PROMPT_PREFIX1}git${YS_VCS_PROMPT_PREFIX2}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$YS_VCS_PROMPT_SUFFIX"
ZSH_THEME_GIT_PROMPT_DIRTY="$YS_VCS_PROMPT_DIRTY"
ZSH_THEME_GIT_PROMPT_CLEAN="$YS_VCS_PROMPT_CLEAN"

# HG info
local hg_info='$(ys_hg_prompt_info)'
ys_hg_prompt_info() {
	# make sure this is a hg dir
	if [ -d '.hg' ]; then
		echo -n "${YS_VCS_PROMPT_PREFIX1}hg${YS_VCS_PROMPT_PREFIX2}"
		echo -n $(hg branch 2>/dev/null)
		if [ -n "$(hg status 2>/dev/null)" ]; then
			echo -n "$YS_VCS_PROMPT_DIRTY"
		else
			echo -n "$YS_VCS_PROMPT_CLEAN"
		fi
		echo -n "$YS_VCS_PROMPT_SUFFIX"
	fi
}

# Prompt format: \n # USER at MACHINE in DIRECTORY on git:BRANCH STATE [TIME] \n $
PROMPT="
%{$terminfo[bold]$fg[blue]%}★%{$reset_color%} \
%{$fg[cyan]%}%n \
%{$fg[white]%}at \
%{$fg[green]%}${host_repr[$HOST]:-$HOST} \
%{$fg[white]%}in \
%{$terminfo[bold]$fg[yellow]%}${current_dir}%{$reset_color%}\
${hg_info}\
${git_info} \
%{$fg[white]%}[%*]
%{$terminfo[bold]$fg[white]%}❯ %{$reset_color%}"

if [[ "$USER" == "root" ]]; then
PROMPT="
%{$terminfo[bold]$fg[blue]%}#%{$reset_color%} \
%{$bg[yellow]%}%{$fg[cyan]%}%n%{$reset_color%} \
%{$fg[white]%}at \
%{$fg[green]%}$(box_name) \
%{$fg[white]%}in \
%{$terminfo[bold]$fg[yellow]%}${current_dir}%{$reset_color%}\
${hg_info}\
${git_info} \
%{$fg[white]%}[%*]
%{$terminfo[bold]$fg[red]%}→ %{$reset_color%}"
fi
