# TRACE Model Demonstration

This repository demonstrates the _Transparent Research Object Vocabulary_ (__TROV__) for describing _Transparent Research Objects_ (__TROs__) and the _Transparent Research Systems_ (__TRS__'s) that produce them.

This repository is itself structured as a _Reproducible Every-Place Research Object_ (__REPRO__). It is associated with a public Docker image that aims to enable the the products of the demonstration to be reproduced at a Unix-like shell prompt on any computer that has Git, GNU Make, and Docker installed.

Make commands issued in the top-level directory are used to obtain the Docker image and run the demos.

## Setup the environment

First start the REPRO in interactive mode using the `make start-repro` command (or the shorthand `make start`).

Then Install the related Python packages using the `pip install .` command.

Finally, exit the REPRO using the `exit` command.

## Run and confirm the reproducibility of the demonstration

The demonstration and its products are stored in the `demo` directory tree:
```
trace-model$ tree demo
demo
├── 01-trov-examples
│   ├── 01-two-artifacts-no-trp
│   │   ├── Makefile
│   │   ├── products
│   │   │   ├── img.gv
│   │   │   ├── img.svg
│   │   │   └── report_subclass.html
│   │   ├── run.sh
│   │   ├── run.txt
│   │   ├── tro
│   │   │   ├── file1
│   │   │   ├── file2
│   │   │   └── tro.jsonld
│   │   └── trs
│   │       ├── private.asc
│   │       ├── public.gpg
│   │       └── trs.jsonld
│   ├── 02-three-artifacts-one-trp
│   │   ├── Makefile
│   │   ├── products
│   │   │   ├── img.gv
│   │   │   ├── img.svg
│   │   │   └── report_subclass.html
│   │   ├── run.sh
│   │   ├── run.txt
│   │   ├── tro
│   │   │   ├── file1
│   │   │   ├── file2
│   │   │   ├── file3
│   │   │   └── tro.jsonld
│   │   └── trs
│   │       ├── private.asc
│   │       ├── public.gpg
│   │       └── trs.jsonld
│   ├── 03-skope-lbda-processing
│   │   ├── Makefile
│   │   ├── mappings.json
│   │   ├── products
│   │   │   ├── img.gv
│   │   │   ├── img.svg
│   │   │   └── report_subclass.html
│   │   ├── report_file
│   │   │   ├── arrangement.svg
│   │   │   ├── overall_tro_graph.html
│   │   │   ├── report.html
│   │   │   ├── tro.svg
│   │   │   └── trp.svg
│   │   ├── report_inline
│   │   │   ├── arrangement.svg
│   │   │   ├── overall_tro_graph.html
│   │   │   ├── report.html
│   │   │   ├── tro.svg
│   │   │   └── trp.svg
│   │   ├── run.sh
│   │   ├── run.txt
│   │   ├── templates.geist
│   │   ├── tro
│   │   │   └── tro.jsonld
│   │   └── tro_report
│   ├── Makefile
│   └── common
│       ├── query-tro.sh
│       └── templates.geist
├── 02-explorations
│   ├── 01-gpg-runtime
│   │   ├── 01-generate-key
│   │   │   ├── Makefile
│   │   │   ├── run.sh
│   │   │   └── run.txt
│   │   ├── 02-simple-tro
│   │   │   ├── Makefile
│   │   │   ├── data
│   │   │   │   ├── private.asc
│   │   │   │   └── public.gpg
│   │   │   ├── run.sh
│   │   │   └── run.txt
│   │   └── Makefile
│   ├── 02-gpg-api
│   │   ├── 01-generate-key
│   │   │   ├── Makefile
│   │   │   ├── run.sh
│   │   │   └── run.txt
│   │   ├── 02-simple-tro
│   │   │   ├── Makefile
│   │   │   ├── data
│   │   │   │   ├── private.asc
│   │   │   │   └── public.gpg
│   │   │   ├── run.sh
│   │   │   └── run.txt
│   │   └── Makefile
│   ├── 03-tro-fingerprint-state
│   │   ├── Makefile
│   │   ├── data
│   │   │   ├── file1.csv
│   │   │   └── file2.csv
│   │   ├── products
│   │   │   ├── after.csv
│   │   │   ├── before.csv
│   │   │   └── fingerprint_state.csv
│   │   ├── run.sh
│   │   ├── run.txt
│   │   ├── runtime
│   │   │   ├── file1.csv
│   │   │   └── file3.csv
│   │   └── test.py
│   ├── 04-timestamp
│   │   ├── Makefile
│   │   ├── data
│   │   │   └── signature.asc
│   │   ├── products
│   │   │   ├── digest.yaml
│   │   │   └── file.tsq
│   │   ├── run.sh
│   │   └── run.txt
│   ├── 05-validate-tro-declaration
│   │   ├── Makefile
│   │   ├── data
│   │   │   ├── mappings.json
│   │   │   ├── tro.schema.ttl
│   │   │   ├── tro1.jsonld
│   │   │   ├── tro2.jsonld
│   │   │   ├── tro3.jsonld
│   │   │   ├── tro4.jsonld
│   │   │   └── tro5.jsonld
│   │   ├── products
│   │   │   ├── tro1.gv
│   │   │   ├── tro1.png
│   │   │   ├── tro2.gv
│   │   │   ├── tro2.png
│   │   │   ├── tro3.gv
│   │   │   ├── tro3.png
│   │   │   ├── tro4.gv
│   │   │   ├── tro4.png
│   │   │   ├── tro5.gv
│   │   │   └── tro5.png
│   │   ├── run.sh
│   │   └── run.txt
│   ├── Makefile
│   └── common
│       ├── certificate
│       │   ├── cacert.pem
│       │   └── tsa.crt
│       └── tro
│           ├── file1
│           ├── file2
│           └── tro.jsonld
└── Makefile
```

To establish that the demonstrations can be reproduced, first use the `make clean-demo` command to delete the files produced by the demo:
```
trace-model$ make clean-demo
------- Cleaning example 01-trov-examples/ ----------------

------- Cleaning example 01-two-artifacts-no-trp/ ----------------
removed './run.txt'
removed './products/img.gv'
removed './products/img.svg'
removed './products/report_subclass.html'
rmdir: removing directory, './products'

------- Cleaning example 02-three-artifacts-one-trp/ ----------------
removed './run.txt'
removed './products/img.gv'
removed './products/img.svg'
removed './products/report_subclass.html'
rmdir: removing directory, './products'

------- Cleaning example 03-skope-lbda-processing/ ----------------
removed './run.txt'
removed './products/img.gv'
removed './products/img.svg'
removed './products/report_subclass.html'
rmdir: removing directory, './products'

------- Cleaning example 02-explorations/ ----------------

------- Cleaning example 01-gpg-runtime/ ----------------

------- Cleaning example 01-generate-key/ ----------------
removed './run.txt'

------- Cleaning example 02-simple-tro/ ----------------
removed './run.txt'

------- Cleaning example 02-gpg-api/ ----------------

------- Cleaning example 01-generate-key/ ----------------
removed './run.txt'

------- Cleaning example 02-simple-tro/ ----------------
removed './run.txt'

------- Cleaning example 03-tro-fingerprint-state/ ----------------
removed './run.txt'
removed './products/after.csv'
removed './products/before.csv'
removed './products/fingerprint_state.csv'
rmdir: removing directory, './products'

------- Cleaning example 04-timestamp/ ----------------
removed './run.txt'
removed './products/digest.yaml'
removed './products/file.tsq'
rmdir: removing directory, './products'

------- Cleaning example 05-validate-tro-declaration/ ----------------
removed './run.txt'
removed './products/tro1.gv'
removed './products/tro1.png'
removed './products/tro2.gv'
removed './products/tro2.png'
removed './products/tro3.gv'
removed './products/tro3.png'
removed './products/tro4.gv'
removed './products/tro4.png'
removed './products/tro5.gv'
removed './products/tro5.png'
rmdir: removing directory, './products'
```

Confirm with `git status` that version-controlled files have been deleted locally:
```
trace-model$ git status
On branch idcc24
Your branch is up to date with 'origin/idcc24'.

Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        deleted:    demo/01-trov-examples/01-two-artifacts-no-trp/products/img.gv
        deleted:    demo/01-trov-examples/01-two-artifacts-no-trp/products/img.svg
        deleted:    demo/01-trov-examples/01-two-artifacts-no-trp/products/report_subclass.html
        deleted:    demo/01-trov-examples/01-two-artifacts-no-trp/run.txt
        deleted:    demo/01-trov-examples/02-three-artifacts-one-trp/products/img.gv
        deleted:    demo/01-trov-examples/02-three-artifacts-one-trp/products/img.svg
        deleted:    demo/01-trov-examples/02-three-artifacts-one-trp/products/report_subclass.html
        deleted:    demo/01-trov-examples/02-three-artifacts-one-trp/run.txt
        deleted:    demo/01-trov-examples/03-skope-lbda-processing/products/img.gv
        deleted:    demo/01-trov-examples/03-skope-lbda-processing/products/img.svg
        deleted:    demo/01-trov-examples/03-skope-lbda-processing/products/report_subclass.html
        deleted:    demo/01-trov-examples/03-skope-lbda-processing/run.txt
        deleted:    demo/02-explorations/01-gpg-runtime/01-generate-key/run.txt
        deleted:    demo/02-explorations/01-gpg-runtime/02-simple-tro/run.txt
        deleted:    demo/02-explorations/02-gpg-api/01-generate-key/run.txt
        deleted:    demo/02-explorations/02-gpg-api/02-simple-tro/run.txt
        deleted:    demo/02-explorations/03-tro-fingerprint-state/products/after.csv
        deleted:    demo/02-explorations/03-tro-fingerprint-state/products/before.csv
        deleted:    demo/02-explorations/03-tro-fingerprint-state/products/fingerprint_state.csv
        deleted:    demo/02-explorations/03-tro-fingerprint-state/run.txt
        deleted:    demo/02-explorations/04-timestamp/products/digest.yaml
        deleted:    demo/02-explorations/04-timestamp/products/file.tsq
        deleted:    demo/02-explorations/04-timestamp/run.txt
        deleted:    demo/02-explorations/05-validate-tro-declaration/products/tro1.gv
        deleted:    demo/02-explorations/05-validate-tro-declaration/products/tro1.png
        deleted:    demo/02-explorations/05-validate-tro-declaration/products/tro2.gv
        deleted:    demo/02-explorations/05-validate-tro-declaration/products/tro2.png
        deleted:    demo/02-explorations/05-validate-tro-declaration/products/tro3.gv
        deleted:    demo/02-explorations/05-validate-tro-declaration/products/tro3.png
        deleted:    demo/02-explorations/05-validate-tro-declaration/products/tro4.gv
        deleted:    demo/02-explorations/05-validate-tro-declaration/products/tro4.png
        deleted:    demo/02-explorations/05-validate-tro-declaration/products/tro5.gv
        deleted:    demo/02-explorations/05-validate-tro-declaration/products/tro5.png
        deleted:    demo/02-explorations/05-validate-tro-declaration/run.txt

no changes added to commit (use "git add" and/or "git commit -a")
```

Now run the demonstration with the `make run-demo` command:
```
trace-model$ make run-demo
---------- Running example 01-trov-examples/ -------------

---------- Running example 01-two-artifacts-no-trp/ -------------

---------- Running example 02-three-artifacts-one-trp/ -------------

---------- Running example 03-skope-lbda-processing/ -------------

---------- Running example 02-explorations/ -------------

---------- Running example 01-gpg-runtime/ -------------

---------- Running example 01-generate-key/ -------------
gpg: key 461685ED23B78A04 marked as ultimately trusted
gpg: directory '/mnt/trace-model/.gnupg-runtime/.gnupg/openpgp-revocs.d' created
gpg: revocation certificate stored as '/mnt/trace-model/.gnupg-runtime/.gnupg/openpgp-revocs.d/3BB586DE799A3BC83447D4B0461685ED23B78A04.rev'
gpg: checking the trustdb
gpg: marginals needed: 3  completes needed: 1  trust model: pgp
gpg: depth: 0  valid:   1  signed:   0  trust: 0-, 0q, 0n, 0m, 0f, 1u

---------- Running example 02-simple-tro/ -------------

---------- Running example 02-gpg-api/ -------------

---------- Running example 01-generate-key/ -------------
gpg: checking the trustdb
gpg: marginals needed: 3  completes needed: 1  trust model: pgp
gpg: depth: 0  valid:   1  signed:   0  trust: 0-, 0q, 0n, 0m, 0f, 1u

---------- Running example 02-simple-tro/ -------------

---------- Running example 03-tro-fingerprint-state/ -------------

---------- Running example 04-timestamp/ -------------
Using configuration from /usr/lib/ssl/openssl.cnf
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  5585    0  5494  100    91  12697    210 --:--:-- --:--:-- --:--:-- 12928
Using configuration from /usr/lib/ssl/openssl.cnf
Warning: certificate from '../common/certificate/tsa.crt' with subject '/O=Free TSA/OU=TSA/description=This certificate digitally signs documents and time stamp requests made using the freetsa.org online services/CN=www.freetsa.org/emailAddress=busilezas@gmail.com/L=Wuerzburg/C=DE/ST=Bayern' is not a CA cert

---------- Running example 05-validate-tro-declaration/ -------------
```

Finally, use `git status` to confirm that the demostration products have been restored:

```
trace-model$ git status
On branch idcc24
Your branch is up to date with 'origin/idcc24'.

nothing to commit, working tree clean
```

## Running a single example

An individual example within the demonstration can be run by starting an interactive REPRO session.

First start the REPRO in interactive mode using the `make start-repro` command (or the shorthand `make start`).
```
trace-model$ make start-repro
repro@a6c7a4e443a8:/mnt/trace-model$
```

Set the working directory to a particular example directory:
```
repro@a6c7a4e443a8:/mnt/trace-model$ cd demo/01-trov-examples/01-two-artifacts-no-trp/
repro@a6c7a4e443a8:/mnt/trace-model/demo/01-trov-examples/01-two-artifacts-no-trp$

repro@a6c7a4e443a8:/mnt/trace-model/demo/01-trov-examples/01-two-artifacts-no-trp$ pwd
/mnt/trace-model/demo/01-trov-examples/01-two-artifacts-no-trp
```

Type `make` to run the example:
```
repro@a6c7a4e443a8:/mnt/trace-model/demo/01-trov-examples/01-two-artifacts-no-trp$ make
bash run.sh > run.txt
```

Use the `tree` command to list the files associated with the example, including the temporary files in the `tmp` subdirectory:

```
repro@a6c7a4e443a8:/mnt/trace-model/demo/01-trov-examples/01-two-artifacts-no-trp$ tree
.
|-- Makefile
|-- products
|   |-- img.gv
|   |-- img.svg
|   `-- report_subclass.html
|-- run.sh
|-- run.txt
|-- tmp
|   |-- import tro declaration.sh
|   |-- import tro declaration.txt
|   |-- import trov vocabulary.sh
|   |-- import trov vocabulary.txt
|   |-- query subclass vocab.sh
|   |-- query subclass vocab.txt
|   |-- query tro attributes.sh
|   |-- query tro attributes.txt
|   |-- query trs attributes.sh
|   |-- query trs attributes.txt
|   |-- reload trov vocabulary without inferences.sh
|   `-- reload trov vocabulary without inferences.txt
|-- tro
|   |-- file1
|   |-- file2
|   `-- tro.jsonld
`-- trs
    |-- private.asc
    |-- public.gpg
    `-- trs.jsonld

4 directories, 24 files
```

The `make clean` command deletes the temporary files and the example output file, `run.txt`:
```
repro@a6c7a4e443a8:/mnt/trace-model/demo/01-trov-examples/01-two-artifacts-no-trp$ make clean
if [[ -f ./"run.txt" ]] ; then                       \
    rm -v ./"run.txt" ;                              \
fi
removed './run.txt'
if [[ -d ./"tmp" ]] ; then                              \
    rm -vf ./"tmp"/* ;                            \
    rmdir -v ./"tmp" ;                            \
fi
removed './tmp/import tro declaration.sh'
removed './tmp/import tro declaration.txt'
removed './tmp/import trov vocabulary.sh'
removed './tmp/import trov vocabulary.txt'
removed './tmp/query subclass vocab.sh'
removed './tmp/query subclass vocab.txt'
removed './tmp/query tro attributes.sh'
removed './tmp/query tro attributes.txt'
removed './tmp/query trs attributes.sh'
removed './tmp/query trs attributes.txt'
removed './tmp/reload trov vocabulary without inferences.sh'
removed './tmp/reload trov vocabulary without inferences.txt'
rmdir: removing directory, './tmp'
if [[ -d ./"products" ]] ; then                       \
    rm -vf ./"products"/* ;                           \
    rmdir -v ./"products" ;                           \
fi
removed './products/img.gv'
removed './products/img.svg'
removed './products/report_subclass.html'
rmdir: removing directory, './products'

repro@a6c7a4e443a8:/mnt/trace-model/demo/01-trov-examples/01-two-artifacts-no-trp$ tree
.
|-- Makefile
|-- run.sh
|-- tro
|   |-- file1
|   |-- file2
|   `-- tro.jsonld
`-- trs
    |-- private.asc
    |-- public.gpg
    `-- trs.jsonld

2 directories, 8 files
```

Confirm that the `run.txt` file and the `products` folder are the version-controlled files associated with this example that has been deleted:
```
repro@a6c7a4e443a8:/mnt/trace-model/demo/01-trov-examples/01-two-artifacts-no-trp$ git status .
On branch idcc24
Your branch is up to date with 'origin/idcc24'.

Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        deleted:    products/img.gv
        deleted:    products/img.svg
        deleted:    products/report_subclass.html
        deleted:    run.txt

no changes added to commit (use "git add" and/or "git commit -a")
```

Re-run the and confirm the `run.txt` file was restored:
```
repro@a6c7a4e443a8:/mnt/trace-model/demo/01-trov-examples/01-two-artifacts-no-trp$ make
bash run.sh > run.txt

repro@a6c7a4e443a8:/mnt/trace-model/demo/01-trov-examples/01-two-artifacts-no-trp$ git status .
On branch idcc24
Your branch is up to date with 'origin/idcc24'.

nothing to commit, working tree clean

```




