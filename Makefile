setup:
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew update
	brew install ansible
	exec $(SHELL) -l

check:
	ansible-playbook -i inventory/local default.yml --check -vv

install:
	ansible-playbook -i inventory/local default.yml -vv
