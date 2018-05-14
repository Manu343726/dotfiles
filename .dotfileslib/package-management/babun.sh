#`/bin/bash

install_package()
{
    print_info COMPONENT "Installing packages '${@}'..."

    translate_packages packages $@

    if [ -n "$packages" ]; then
        pact install "${packages}"
    fi
}

update_system()
{
    print_info COMPONENT "Updating system..."

    pact update
}
