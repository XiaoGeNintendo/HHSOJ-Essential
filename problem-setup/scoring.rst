====================
Dealing with scoring
====================

Scoring is a big part of the features of HHSOJ-Essential.

----------------------------------
What's the score of each testcase?
----------------------------------

The score of a testcase is a float from 0.0 to 1.0.
Accepted are considered as 1.0 and other verdicts are considered as 0.0.
If the checker returned a score, that score will be used.

------------------------------
What's the score of a subtask?
------------------------------

The score of a subtask is defined as the scheme function over the testcase scores.

For example, if in a subtask, the scores are ``[0,1,0.5]``

.. list-table::
   :widths: 25 25
   :header-rows: 1

   * - Scheme
     - Result
   * - min
     - 0
   * - max
     - 1
   * - sum
     - 1.5
   * - avg
     - 0.5

---------------------------------
What's the score of a submission?
---------------------------------

The score of a submission is defined as the weighted sum of the score of each subtask. 

Let the number of subtasks to be :math:`N`, score of the i-th subtask to be :math:`S_i`
and the base score ratio is :math:`B_i`.

The score of the submission :math:`S_S=\Sigma^N_{i=0}S_iB_i`

When displaying, the value will be multipied by 100.