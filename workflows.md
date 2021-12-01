# ZULUDICT Workflows

This document describes the workflows involved in creating ZuluDict.

## Interface creation
To set up directory structure, index.html, js and css webDictEditor.exe was used.

* Start exe: Control
* Tabsheet 'Config': tick 'Application Builder'
* Tabsheet 'App. Builder'
* Fill in and tick required checkboxes
* Push 'Create Files'
* Edit Data
* Create Website


## Data
The web dictionary expects all data in one basex database.

* Run create_zul_eng_publ.xq to create dc_zul_eng__publ
* Run create_zul_eng_ind.xq to create dc_zul_eng__publ__ind
* Copy data to server (hephaistos)

And bob's your uncle