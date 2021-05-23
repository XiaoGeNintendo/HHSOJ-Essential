=================
Frontend Building
=================

Frontend is the display layer of the OJ. It is made :del:`ugily` simply.
It should be built on the same machine as the Server Manager

---------------------------------
Downloading Tomcat & The War Pack
---------------------------------

After downloing the War file in the Github release,
you need to put it in the webapps folder of the Tomcat.
Then, go to the bin folder of Tomcat. Run ``./startup.sh`` or ``startup.bat``
depending on you OS to start the server.

.. note:: To shut down the server, just run ``./shutdown.sh`` or ``shutdown.bat``

----------------------
Setting up config file
----------------------

Now, your website should be able to found at ``http://localhost:8080/HellOJ``,
enter the "Problemsets" page and you will see an Internal Server Error message.
Now you need to set up a config file. The file's location varies from system to system.
It's related to your calling position. But if you don't know,
open ``<tomcat path>/logs/catalina.out`` and you should be seeing an error message 

.. code-block:: text
   
   FATAL: CANNOT FIND CONFIG FILE. SEE DOCUMENTATION FOR DETAIL

   EXPECTED TO FIND IT HERE: <somewhere>

Then the place is where you need to create a config file.
In the config file(named config.json), write the following things:

.. code-block:: text
    
    {
        "port":7512, //port of the server manager
        "path":"G:/test/server" //the location of the server manager
    }

and you are set!