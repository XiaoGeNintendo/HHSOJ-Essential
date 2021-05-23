===============
Judger Building
===============

.. toctree::
   :maxdepth: 2
   :hidden:

   judger-building/installing-lo-runner
   judger-building/core-py-return-code-list

--------------
Prerequirement
--------------

* Linux OS
* `Java 1.8 <https://www.java.com/>`_
* `Python 3.6 <https://www.python.org/>`_
* The python library `Lo-runner <https://xgn.gitbook.io/hhsoj-essential-doc/building/judger-building/installing-lo-runner>`_
* Internet Connection to the Server Manager
* Compilers and runners

---------------
Downloading Zip
---------------

There're two types of releases on Github. The first type gives you a zip("release pack"), 
the second type gives you a jar("update pack").
The first time, you need to download a release pack.
And when updating, just replace the jar with update pack. 

Download the judger jar and required library from 
the github `releases <https://github.com/XiaoGeNintendo/HHSOJ-Essential/releases>`_.
Run it in the command line with the following arguments:

.. code-block:: text
   
   java -jar Judger.jar <ip> <port> <name>

* ``ip`` should be the IP of the server manager
* ``port`` should be the port of the server manager
* ``name`` should be the name of the judger. Any name is acceptable. Avoid duplicate names.