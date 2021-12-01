# zuludict-app

Charly Moerth (ed.):    
*A machine-readable isiZulu-English glossary*

Vienna, [ACDH-CH](https://www.oeaw.ac.at/acdh) 2011–2021

## Description

This is the web application code of the ACDH-CH Zulu dictionary available at [https://zuludict.acdh-dev.oeaw.ac.at/](https://zuludict.acdh-dev.oeaw.ac.at/). It is built using the [*Web Dictionary*-feature](https://clarin.oeaw.ac.at/lrp/dict-gate/vle_docu/vle_docu__v001.html#web_dictionary) of the [Vienna Lexicographic Editor (VLE)](https://www.oeaw.ac.at/acdh/tools/vle).

## Setup instructions

* Get an up-to-date version of the BaseX XML database from <https://basex.org/> (We will assume BaseX is installed into `/opt/basex`. If not, update the following commands accordingly.)
* Download the Saxon HE library from <https://www.saxonica.com/download/java.xml> and place it in the `lib/custom` directory in the BaseX installation path.
* clone this repository to `$BASEX_HOME/webapp`
* clone the data repository to a handy place (see below)
* import both directories from the data repository by running the following commands: 

```bash
/opt/basex/bin/basex -c 'CREATE DATABASE dc_zu_eng__publ; CREATE DATABASE dc_zul_eng__publ__ind'
/opt/basex/bin/basex -c 'OPEN dc_zu_eng__publ; ADD dc_zul_eng__publ;'
/opt/basex/bin/basex -c 'OPEN dc_zu_eng__publ__ind; ADD dc_zul_eng__publ__ind;'
```

Now fire up the basex http server by running

```bash
/opt/basex/bin/basexhttp
```
The application should be available under <http://localhost:8984/zuludict/index.html>.

## Data

The data is being edited using an installation of the [Vienna Lexicographic Editor (VLE)](https://www.oeaw.ac.at/acdh/tools/vle) using a [BaseX native XML database](https://basex.org/) as its backend. The data is released at irregular intervals at <https://github.com/acdh-oeaw/zuludict-data>.

## Want to know more? 

Contact us at <acdh-helpdesk@oeaw.ac.at>
