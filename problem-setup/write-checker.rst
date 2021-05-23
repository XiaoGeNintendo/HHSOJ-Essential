================
Writing checkers
================

.. warning::
    It's strictly recommended to write checkers in `Testlib.h <https://github.com/MikeMirzayanov/testlib>`_

    Learn it `here <https://codeforces.com/testlib>`_ if you don't know

The time limit for the checker is 30 seconds.

---------------
Using testlib.h
---------------

Write a normal checker in testlib's format and compile it.

You are done!

------
Manual
------

The checker will be called with four arguments:

``checker <input path> <output path> <answer path> <report path>``

You should read from the first three paths and write the checker comment to report path.

Your program should return 0 when the solution is accepted.

Return anything except 0 and 7 when the solution is not correct.

When returning 7, the first token in the report file should be the score of the testcase.