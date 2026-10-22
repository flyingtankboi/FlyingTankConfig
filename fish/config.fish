if status is-interactive
	#fish config
	set -g fish_greeting ""
	#starship
	starship init fish | source
	#alias
	abbr -a sensors-main sensors asus-isa-000a k10temp-pci-00c3
end
