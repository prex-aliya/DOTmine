#! /bin/bash
dir=$HOME/Music

findparms=(-name '*.mp3' -or -name '*.wav' -or -name '*.m4a')
mpvparms=(--no-video)
fzfparms=(--multi)

declare -a plist

if [ "$1" = "-m" ]; then
	(find "$dir" "${findparms[@]}" | sed "s%${dir}/%%") \
		| fzf "${fzfparms[@]}" | {

		while IFS='' read -r f; do
			plist+=("${dir}/${f}")
		done

		[[ ${#plist[@]} > 0 ]] && exec mpv "${mpvparms[@]}" "${plist[@]}"
	}
fi

mpv --shuffle ${dir}
