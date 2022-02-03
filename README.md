# zuludict-app

Charly Moerth (ed.):
*A machine-readable isiZulu-English glossary*

Vienna, [ACDH-CH](https://www.oeaw.ac.at/acdh) 2011–2021

## Description

This is the web application code of the ACDH-CH Zulu dictionary available at [https://zuludict.acdh-dev.oeaw.ac.at/](https://zuludict.acdh-dev.oeaw.ac.at/). It is built using the [*Web Dictionary*-feature](https://clarin.oeaw.ac.at/lrp/dict-gate/vle_docu/vle_docu__v001.html#web_dictionary) of the [Vienna Lexicographic Editor (VLE)](https://www.oeaw.ac.at/acdh/tools/vle).

## Set up a local container instance

We use container images built here on GitHub to run the public service.
To fetch the latest image use

```bash
docker pull ghcr.io/acdh-oeaw/zuludict-app:master
```

To run the latest image use

```bash
docker run --rm -it -p 8984:5000 ghcr.io/acdh-oeaw/zuludict-app:master
```

## Set up a local instance

### Prerequisites

* Java LTS ([Oracle](https://www.oracle.com/java/technologies/javase-downloads.html),
  [Azul](https://www.azul.com/downloads/zulu-community/?version=java-11-lts&package=jdk),
  or others) (11 at the moment)
* [Node LTS](https://nodejs.org/) (14 at the moment)
* git ([for Windows](https://gitforwindows.org/), shipped with other OSes)
* curl for downloading [Saxon HE](https://www.saxonica.com/download/java.xml)
  (10.6 at the moment, curl is included with git for windows)
* This git repository needs to be cloned inside a [BaseX ZIP-file distribution](https://basex.org/download/)
  (9.6.4 at the moment)

### Setup

* unzip BaseX*.zip (for example in your home folder)
  `<basexhome>` is the directory containing `BaseX.jar` and the `bin`, `lib` and
  `webapp` directory (`basex` after unpacking the BaseX*.zip file, but you should
  probably rename it)
* in `<basexhome>/webapp` git clone this repository,
  please do not change the name `zuludict-app`
* start a bash in `<basexhome>/webapp/zuludict-app`
* run `./deployment/initial.sh`

This will clone [zuludict-data](https://github.com/acdh-oeaw/zuludict-data)
into `<basexhome>`.

### Update data and web page code

In `<basexhome>` execute `./redeploy.sh`

## Accessing the app

Now fire up the basex http server by running

```bash
/opt/basex/bin/basexhttp
```

If you just ran `initial.sh` or `redeploy.sh` this is already done.

The application should be available under <http://localhost:8984/zuludict/index.html>.

## Data

The data is being edited using an installation of the [Vienna Lexicographic Editor (VLE)](https://www.oeaw.ac.at/acdh/tools/vle) using a [BaseX native XML database](https://basex.org/) as its backend. The data is released at irregular intervals at <https://github.com/acdh-oeaw/zuludict-data>.

## Want to know more?

Contact us at <acdh-helpdesk@oeaw.ac.at>
