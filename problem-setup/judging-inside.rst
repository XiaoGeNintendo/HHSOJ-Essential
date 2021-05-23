==============
Judging Inside
==============

In this section, we will talk about the judging process.

-----------------------------
Step 1 - Receiving Submission
-----------------------------

The Judger receives the submission from the Manager
and fills the ``judger`` attribute of the submission.

-------------------------
Step 2 - Downloading Data
-------------------------

If the Judger is missing problem data
(i.e: problem version not right, problem folder empty),
it will download data from manager.

-----------------------
Step 3 - Compiling Code
-----------------------
The code gets compiled

--------------------
Step 4 - Run Subtask
--------------------
The subtasks get run one by one according to the `order <problem-json-file.html>`_

In each subtask, the testcases are run one by one according to their ID.
Once the program gets a non-accepted verdict(i.e:anything except **Accepted** and **Point**)
and the ``toEnd`` `attribute <problem-json-file.html#the-testmap>`_ is false, the subtask is skipped.

---------------
Step 5 - Finish
---------------

The judger returns the submission when it is finished.