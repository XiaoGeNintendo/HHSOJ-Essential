=====================
The problem.json File
=====================

The problem.json file contains the basic information of a problem. It is placed under the problem folder.

.. note:: You need basic Json skills before continuing. Google it if you don't know.

---------------------
The Problem Attribute
---------------------

The file itself is a object, so start it by writing a pair of ``{}``.

.. list-table::
   :header-rows: 1

   * - Element
     - Type
     - Explanation
     - Example
   * - name
     - String
     - Name
     - "A+B Problem"
   * - tl
     - Integer
     - Time Limit per test in ms
     - 1000
   * - ml
     - Integer
     - Memory Limit per test in KB
     - 262144
   * - ver
     - Integer
     - the current problem version. Should be positive
     - 1
   * - diff
     - Float
     - [WIP]The difficulty of the problem
     - 1.0
   * - tests
     - TestMap
     - The subtask detail
     - 
   * - order
     - String[]
     - The order of the subtasks to be judged.
       
       Should represent a subtask by its ID
     - 

-----------
The TestMap
-----------

TestMap contains information for subtasks. Each key maps to the id of a subtask,
each value maps to the configuration for that subtask. Each subtask has the following arguments:

.. list-table::
   :header-rows: 1

   * - Element
     - Type
     - Explanation
     - Example
   * - scheme
     - String
     - Should be one from "min" "max" "sum" "avg"
       
       The marking scheme for the subtask
     - "min"
   * - requirement
     - String[]
     - All subtasks in requirement should be passed in order to test this subtask.
        
       Represent subtasks by their ID.
       
       All subtasks in requirement should be judged earlier than this.
     - []
   * - toEnd
     - Boolean
     - Declares that all testcases in this subtask should be tested
       
       Often used when scheme is "sum" "avg"
     - true
   * - score
     - Float
     - the base score ratio of this subtask. Expected: 0.0~1.0
     - 0.6

--------------------
Example Problem.json
--------------------

.. code-block:: JSON
  
  {
    "name":"Test Problem",
    "tl":1000,
    "ml":262144,
    "ver":7,
    "order":["easy","hard"],
    "diff":2.0,
    "tests":{
      "easy":{
        "scheme":"min",
        "requirement:":[],
        "toEnd":true,
        "score":0.6
      },
      "hard":{
        "scheme":"sum",
        "requirement":["easy"],
        "toEnd":false,
        "score":0.2
      }
    }
  }
