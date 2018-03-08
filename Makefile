ANSIBLE_COMMAND   = ansible-playbook
ANSIBLE_INVENTORY = inventory/local
ANSIBLE_PLAYBOOK  = default.yml

.PHONY: all

all: pre-install install

pre-install: pre-install-homebrew pre-install-ansible

pre-install-homebrew:
ifeq ($(shell which brew),)
	/usr/bin/ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
endif

pre-install-ansible:
ifeq ($(shell which ansible-playbook),)
	brew update
	brew install ansible
	hash -r
endif

lint:
	$(ANSIBLE_COMMAND) -i $(ANSIBLE_INVENTORY) $(ANSIBLE_PLAYBOOK) --syntax-check -vv

check:
	$(ANSIBLE_COMMAND) -i $(ANSIBLE_INVENTORY) $(ANSIBLE_PLAYBOOK) --check -vv

install:
	$(ANSIBLE_COMMAND) -i $(ANSIBLE_INVENTORY) $(ANSIBLE_PLAYBOOK) -vv
