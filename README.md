IdP Vagrants
------------

This project contains a handful of useful [Vagrant](https://www.vagrantup.com/) images of the Shibboleth IdP 3.x
intended to facilitate software development and testing.

The following images are provided:

1. idp-base: IdP with in-memory session storage and password-based authentication against OpenLDAP
2. idp-postgresql: Base, but with PostgreSQL session storage

Ten test users, defined in /ldap/users.ldif, are provided to support testing password authentication flows. The
credentials are of the form _testN/passwordN_.
