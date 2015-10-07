IdP Vagrant Machines
====================

This project contains a handful of useful [Vagrant](https://www.vagrantup.com/) virtual machine configurations
of the [Shibboleth IdP 3.x](https://wiki.shibboleth.net/confluence/display/IDP30/Home) software intended to
facilitate software development and testing.

The following machines are provided:

1. idp-base: IdP with in-memory session storage and password-based authentication against OpenLDAP
2. idp-postgresql: Base, but with PostgreSQL session storage

All machines are based on Ubuntu 14.04 (Trust Tahr).

Running a Machine
-----------------
Obviously you must download and install Vagrant as well as a supported virtualization platform before attempting to
run a machine. [VirtualBox](https://www.virtualbox.org/wiki/Downloads) is the default virtualization provider and is
supported on every platform that Vagrant supports.

1. Open a terminal and cd into one of the idp-X directories
2. Type `vagrant up`
3. Open a browser to https://localhost:8443/idp/status and verify the IdP status information is rendered
4. Test as needed

Ten test users, defined in /ldap/users.ldif, are provided to support testing password authentication flows. The
credentials are of the form _testN/passwordN_.

Shell access to the machine is provided via the `vagrant ssh` command, and commands are executed as root by simply
prepending `sudo` as usual with Debian-based Linux distributions.
