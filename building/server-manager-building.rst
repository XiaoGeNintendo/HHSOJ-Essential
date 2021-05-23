=======================
Server Manager Building
=======================

.. note:: **Maven** version has server manager built into the webapp.
          Ignore this section if you are using **Maven** version.

Building a server manager is important yet easy.

--------------
Prerequirement
--------------

* Any OS
* `Java 1.8 <https://www.java.com/>`_
* Internet Connection

---------------
Downloading Jar
---------------

Download the jar or the configured server manager zip from the Github release.
Run it with the following argument:

.. code-block:: text
   
   java -jar Manager.jar <port>

* ``port`` is the port the server manager will listen on. 7512 is recommended.

----------------------
Creating configuration
----------------------

Auto
====

If you have downloaded the pre-configured server manager zip from the Github release,
you don't need to do anything! Hooray! 

But, if you want to add languages other than the sample one, jump to `Language Setup <../language-setup.html>`_!

Manual
======

Create a folder called "config" and create a file called "lang.json".
Then jump to the `Language Setup`_ section.