======================
Problem structure:Full
======================

The **full** structure of a problem contains:

.. code-block:: text
  
  problems/someProblemset/problemId/
                                problem.json
                                checker
                                statement.md(pdf)
                                subtask1/
                                        test0.in
                                        test0.out
                                        test1.in
                                        test1.out
                                        ...
                                subtask2/
                                subtask3/
                                ...

The name of the folder of the problem is the problem id.
It should be short and easy to type.
The **problem.json** contains the basic information of the problem and the scoring of subtasks.
The **checker** is the executable file of the checker.
The **statement.md** is the statement file in Markdown,or in PDF format.
The subtask names can be changed as you like. You shouldn't change the testcases' names.

.. note:: The name of the folder of the subtask is called the **id of the subtask**
