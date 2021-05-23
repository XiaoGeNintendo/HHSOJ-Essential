==============
Language Setup
==============

HHSOJ-Essential supports customizing and adding new programming languages.
They are defined in ``config/lang.json`` in Server Manager's folder.

-----------------
Adding a language
-----------------

Write your ``lang.json`` file as follows:

.. code-block:: text

    {
        "cpp":{ //the id of the language
            "ext":"cpp", //the extension name of the language
            "name":"GNU C++ 11", //the display name of the language
            "compileCmd":["g++","Main.cpp","-o","Main.exe","-O2","-DONLINE_JUDGE","-std=gnu++11"], //the command line to be called when compiling. Write each piece of argument in a string.
            "runCmd":["./Main.exe"], //the command line to be called when running
            "opCode":[1,2,3,4],  //the permitted system calling code.
            "file":[],// the permitted reading files
            "aceName":"c_cpp" //the ACE ID for displaying. Only needed in Maven version.
        },
        "someOtherLang":{...}
    }

.. note::
    The reason why we need ``opCode`` and ``file`` is to prevent codes from doing something dangerous.
    For example, you should never allow a program to delete all files in your server!
    These two arguments differ from language to language, server to server maybe.

.. warning::
    Important: You have to restart the Judger after changing ``lang.json``!
    It's not necessary to restart the Manager, but it's recommended to do so.

.. note::
    You can Google or explore `Ace official site <https://ace.c9.io/>`_ to get the language's ace code.
    Mostly it's just the language name in lower case. One exception is C/C++.

    Note that this field is only needed if you use Maven version.