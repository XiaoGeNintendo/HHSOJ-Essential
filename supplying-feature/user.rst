====
User
====

User is the core mechanic of a OJ. They are stored in ``<path>/users`` with number ids as filename.

Three properties are stored:

* Username
* Password
* isAdmin - you need to set it manually by modify the text file

.. error:: **Password is stored in plain text. When building, please take this into account in your privacy policy.**

----------------
Admin Privileges
----------------

When logged as a admin, you have special power to :del:`destroy the OJ`

.. warning:: The following applies to **Maven Edition >=3.3.0** only

Rejuding
========

You can always rejudge a program on the submission page.

Rebasing
========

Refer to `rebase <standings.html#rebase>`_
