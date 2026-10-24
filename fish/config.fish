if status is-interactive
	#fish config
	set -gx SUDO_PROMPT (set_color D00003)"▌"(set_color -o FFF0E2)" //AUTH "(set_color normal)(set_color DDD1C4)"password for %u: "(set_color normal)
	set -g fish_greeting ""
	#starship
	starship init fish | source
	# zoxide
	zoxide init --cmd cd fish | source
	#alias
	abbr -a sensors-main sensors asus-isa-000a k10temp-pci-00c3
	alias ls="eza --color=auto"
end
