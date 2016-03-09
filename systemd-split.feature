Feature: Systemd package split
    https://fedoraproject.org/wiki/Changes/systemd_package_split

    Two new subpackages will be split out from the main systemd package.
    systemd-container will contain stuff for launching and managing VMs and
    containers. system-udev will contain udevd and other hardware-related bits.

    Background: Fedora 24
        Given target version of system is Fedora 24

    Scenario: systemd package split
        Given systemd package is split to subpackages
        When systemd binary package is built
        Then systemd-container.rpm subpackage is built
        And systemd-udev.rpm is built

    Scenario: systemd-container.rpm contents
        Given systemd-container.rpm is installed
        When querying rpm database
        Then the subpackage should provide systemd-nspawn
        And the subpackage should provide systemd-machined
        And the subpackage should provide machinectl
        And the subpackage should provide systemd-importd
        And the subpackage should provide systemd-pull

    Scenario: systemd-udev.rpm contents
        Given systemd-udev.rpm is installed
        When querying rpm database
        Then the subpackage should provide systemd-udevd
        And the subpackage should provide udevadm
        And the subpackage should provide udev rules
        And the subpackage should provide the hardware database

