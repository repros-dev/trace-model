# TRACE Model Demonstrations

This repository demonstrates the _Transparent Research Object Vocabulary_ (__TROV__) for describing _Transparent Research Objects_ (__TROs__) and the _Transparent Research Systems_ (__TRS__'s) that produce them.

This repository is itself structured as a _Reproducible Every-Place Research Object_ (__REPRO__). It is associated with a public Docker image that aims to enable the the products of the demonstration to be reproduced at a Unix-like shell prompt on any computer that has Git, GNU Make, and Docker installed.

Make commands issued in the top-level directory are used to obtain the Docker image and run the demos.

## Obtaining the Docker image for this REPRO

Use the `make pull-image` command to pull the Docker image from Docker hub:
```
trace-model$ make pull-image
docker pull cirss/trace-model:latest
latest: Pulling from cirss/trace-model
d19f32bd9e41: Pull complete
f9e098bd9304: Pull complete
bd67e18a393a: Pull complete
a999842c6b8b: Pull complete
5879f0773d6f: Pull complete
d735389eb5d9: Pull complete
de60b39ca69a: Pull complete
ac79dbfddb45: Pull complete
633a376f999c: Pull complete
4c1f583c231d: Pull complete
40499f468cf6: Pull complete
438476b07eca: Pull complete
66c6f2f0117d: Pull complete
Digest: sha256:013dc3261b141fc79d7bbc5e9cede4376951917f29fa282feebe68b23eaa6666
Status: Downloaded newer image for cirss/trace-model:latest
docker.io/cirss/trace-model:latest
```

Alternatively, build the image locally using the `make build-image` command:
```
/trace-model$ make build-image
docker build -t cirss/trace-model:latest .
Sending build context to Docker daemon  292.1MB
Step 1/12 : FROM cirss/repro-parent:latest
latest: Pulling from cirss/repro-parent
Digest: sha256:9b589a67c0e43ebaa6a99b7a64fc9ceaf3935ae99550366d323701425dbc2418
Status: Downloaded newer image for cirss/repro-parent:latest
 ---> 7fe3395196d6
Step 2/12 : COPY exports /repro/exports
 ---> 5493da08ada1
Step 3/12 : ADD ${REPRO_DIST}/boot-setup /repro/dist/
Downloading  1.315kB
 ---> a84c9e2d5371
Step 4/12 : RUN bash /repro/dist/boot-setup
 ---> Running in 6b41b98cbc46
Get:1 http://security.ubuntu.com/ubuntu jammy-security InRelease [110 kB]
Hit:2 http://archive.ubuntu.com/ubuntu jammy InRelease
Get:3 http://archive.ubuntu.com/ubuntu jammy-updates InRelease [114 kB]
.
.
.
Step 12/12 : CMD  /bin/bash -il
 ---> Running in 0253e7b96eae
Removing intermediate container 0253e7b96eae
 ---> d183e074b43e
Successfully built d183e074b43e
Successfully tagged cirss/trace-model:latest
```

## Running and confirming the reproducibility of the demonstration

The demonstration and its products are stored under in the `demo` directory tree:
```
trace-model$ tree demo
demo
├── 01-minimal
│   ├── Makefile
│   ├── run.sh
│   └── run.txt
├── 02-type-a
│   ├── Makefile
│   ├── run.sh
│   └── run.txt
├── common
│   ├── trace-vocab.jsonld
│   ├── tro
│   │   ├── tro-01-from-minimal-trs.jsonld
│   │   └── tro-02-from-type-a-trs.jsonld
│   ├── trs
│   │   ├── trs-01-minimal.jsonld
│   │   └── trs-02-type-a.jsonld
│   └── trs-queries.sh
└── Makefile
```

To establish that the demonstrations can be reproduced, first use the `make clean-demo` command to delete the files produced by demo:
```
trace-model$ make clean-demo
20221008.054458.104 A MESG Connect to Blazegraph at http://localhost:9999. [/home/repro/repro-modules/repro/base-functions:repro.announce_services:331]

------- Cleaning example 01-minimal/ ----------------
removed './run.txt'

------- Cleaning example 02-type-a/ ----------------
removed './run.txt'
```

Confirm with `git status` that version-controlled files have been deleted locally:
```
trace-model$ git status
On branch master
Your branch is up to date with 'origin/master'.

Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

	deleted:    demo/01-minimal/run.txt
	deleted:    demo/02-type-a/run.txt

no changes added to commit (use "git add" and/or "git commit -a")
```

Now the run the demonstration with the `make run-demo` command:
```
trace-model$ make run-demo
20221008.051511.921 A MESG Connect to Blazegraph at http://localhost:9999. [/home/repro/repro-modules/repro/base-functions:repro.announce_services:331]

---------- Running example 01-minimal/ -------------

---------- Running example 02-type-a/ -------------
```

Finally, use `git status` to confirm that the demostration products have been restored:

```
trace-model$ git status
On branch master
Your branch is up to date with 'origin/master'.

no changes added to commit (use "git add" and/or "git commit -a")
```
