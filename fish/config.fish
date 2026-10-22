if status is-interactive
	#starship
	starship init fish | source
	#alias
	abbr -a sensors-main sensors asus-isa-000a k10temp-pci-00c3
end
