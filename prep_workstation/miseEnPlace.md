# Mise en place
Notes from the initial setup of the monorep, hardware, and tools on admin machine.

## hardware

- setup 3 ubuntu 20.04 servers
- setup ssh auth
- setup basic ansible inventory and ping module test.
- upgrade packages to latest

## workstation toolbox
bundle of tools to install.

run the following in this directionry ./notes:

    brew install $(<packages.txt)

required

    brew install ansible@2.9
    brew install direnv
    brew install flux
    brew install age
    brew install go-task
    brew install ipcalc
    brew install jq
    brew install kubectl
    brew install sops
    brew install terraform

optional

    brew install helm
    brew install kustomize
    brew install pre-commit
    brew install prettier

If using ansible 2.9.

    echo 'export PATH="/usr/local/opt/ansible@2.9/bin:$PATH"' >> ~/.zshrc

setup pre-commit.

    pre-commit install-hooks

mkdir -p ~/.config/sops/age
mv age.agekey ~/.config/sops/age/keys.txt

export SOPS_AGE_KEY_FILE=~/.config/sops/age/keys.txt
source ~/.zshrc

## notes
