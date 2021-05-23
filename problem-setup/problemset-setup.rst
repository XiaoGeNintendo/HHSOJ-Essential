================
Problemset Setup
================

Problemsets are like the fathers of problems. 
Each problem is contained in exactly one problemset and each problemset contains several questions.

A problemset is defined in a folder under the ``problems`` folder in the manager main folder.
It has the following format:

.. code-block:: text

    problems/problemset1/
                        problemset.json
                        problem1.1
                        problem1.2
                        problem1.3
                        ...
            problemset2/
                        problemset.json
                        problem2.1
                        problem2.2
                        problem2.3
                        ...

the folder name is the **id** of the problemset. It should be short and easy to type.
the **problemset.json** is a required file. It looks like follows:

.. code-block:: text

    {
        "name":"Some problemset", //the name of the problemset
        "stTime":0, //the start time of the problemset,
        "edTime":1145141919810, //the freeze time of the problemset
        "scheme":"first" //Which submission to show in the standing? Can be one in "first" "last" "best"
    }

the problem can only be viewed after the **stTime** and the standing of the problemset
will freeze after **edTime**. **stTime** and **edTime** are all Unix timestamps by ms.
You can read more about `standing <supplying-feature/standings>`_ here.

.. note:: You can generate stTime and edTime by calling ``System.currentTimeMillis()`` in Java.

Each subfolder in each problemset contains exactly one problem. 
