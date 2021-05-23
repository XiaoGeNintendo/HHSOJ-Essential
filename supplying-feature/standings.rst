=========
Standings
=========

.. warning:: Only **Maven Edition >=3.3.0** has this feature.

A simple standing system is packed into the system.
You can always extend it by modifying the source code.

Each problemset will have its own standing.
Unfortunately, you can't create a global standing. 

-------------
Quick startup
-------------

The standing is automatically enabled.
You don't have to do anything. Hooray!

If you find old submissions missing on the standing table, rebase it.

--------
Workings
--------

When starting the server up, the Server Manager will load all the caches from

``<hhsoj path>/cache/<problemset id>``

When a submission updates, the standing is updated and written again to the cache.
The manager never rebases automcatically.

There are 3 types of update policy, as specified in `Problemset <../problem-setup/problemset-setup.html>`_:

* ``first`` only count the submission with smallest submission time. Useful for OI format or one-hit contest.
* ``last`` only count the submission with largest submission time. Useful for CF format.
* ``best`` count the submission with highest score. Useful for normal problemsets.

When edTime of the problemset is reached, the standing freezes and never updates.

------
Rebase
------

Rebase refers to the process of rebuilding the whole standing table.
It will read every submission and add them to the standing table if possible.
It is useful if the cache is corrupted, manual data is loaded or you simply want to waste CPU work time.

When logged in as a Admin Account, you can manual rebase on the standing page.

.. warning:: 
    This process is done on the Server Manager while Tomcat is only a messenger.
    Even if a 'success' is returned, it's still possible for the manager to fail.
    Check catalina.out if you believe something is wrong.
