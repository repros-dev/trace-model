#!/usr/bin/env bash

MESSAGE_DIR=data/message
MESSAGE_FILE=data/message/bar.txt,data/message/foo.txt,data/message/baz/baz.txt
MESSAGE_SUBDIR=data/message/baz
MESSAGE_FILE_WITHOUT_SUBDIR=data/message/bar.txt,data/message/foo.txt

MESSAGE_WITH_DIFF_FILENAMES_DIR=data/message_with_diff_filenames
MESSAGE_WITH_DIFF_FILENAMES_FILE=data/message_with_diff_filenames/test1.txt,data/message_with_diff_filenames/test2.txt,data/message_with_diff_filenames/test3/test3.txt
MESSAGE_WITH_DIFF_FILENAMES_SUBDIR=data/message_with_diff_filenames/test3
MESSAGE_WITH_DIFF_FILENAMES_FILE_WITHOUT_SUBDIR=data/message_with_diff_filenames/test1.txt,data/message_with_diff_filenames/test2.txt

TRO_JSONLD_FILE=products/tro.jsonld

# ------------------------------------------------------------------------------

bash_cell 'get fingerprint based on tro_fingerprint.py (directory)' << END_CELL

python3 tro_fingerprint.py -d ${MESSAGE_DIR}

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'get fingerprint based on tro_fingerprint.py (file)' << END_CELL

python3 tro_fingerprint.py -f ${MESSAGE_FILE}

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'get fingerprint based on tro_fingerprint.py (directory and file)' << END_CELL

python3 tro_fingerprint.py -d ${MESSAGE_SUBDIR} -f ${MESSAGE_FILE_WITHOUT_SUBDIR}

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'create tro manifest containing the digest of data (directory)' << END_CELL
python3 << END_PYTHON
from tro_fingerprint import compute_fingerprint
import json

fingerprint = compute_fingerprint(arg_dir="${MESSAGE_DIR}", arg_file=None)

fout = open("${TRO_JSONLD_FILE}", mode="w", encoding="utf-8")
jsonld_content = {
    "@context": [{
        "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
        "trov": "https://w3id.org/trace/2022/10/trov#"
    }],

    "@graph": [{

        "@id": "trov:tro/01",
        "@type": "trov:ResearchObject",

        "trov:generatedBySystem": { "@id": "trov:system/01" },
        "trov:fingerprint": fingerprint
    }]
}
json.dump(jsonld_content, fout, indent=4)

fout.close()
END_PYTHON
cat ${TRO_JSONLD_FILE}
END_CELL

# ------------------------------------------------------------------------------

bash_cell 'create tro manifest containing the digest of data (file)' << END_CELL
python3 << END_PYTHON
from tro_fingerprint import compute_fingerprint
import json

fingerprint = compute_fingerprint(arg_dir=None, arg_file="${MESSAGE_FILE}")

fout = open("${TRO_JSONLD_FILE}", mode="w", encoding="utf-8")
jsonld_content = {
    "@context": [{
        "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
        "trov": "https://w3id.org/trace/2022/10/trov#"
    }],

    "@graph": [{

        "@id": "trov:tro/01",
        "@type": "trov:ResearchObject",

        "trov:generatedBySystem": { "@id": "trov:system/01" },
        "trov:fingerprint": fingerprint
    }]
}
json.dump(jsonld_content, fout, indent=4)

fout.close()
END_PYTHON
cat ${TRO_JSONLD_FILE}
END_CELL

# ------------------------------------------------------------------------------

bash_cell 'create tro manifest containing the digest of data (directory and file)' << END_CELL
python3 << END_PYTHON
from tro_fingerprint import compute_fingerprint
import json

fingerprint = compute_fingerprint(arg_dir="${MESSAGE_SUBDIR}", arg_file="${MESSAGE_FILE_WITHOUT_SUBDIR}")

fout = open("${TRO_JSONLD_FILE}", mode="w", encoding="utf-8")
jsonld_content = {
    "@context": [{
        "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
        "trov": "https://w3id.org/trace/2022/10/trov#"
    }],

    "@graph": [{

        "@id": "trov:tro/01",
        "@type": "trov:ResearchObject",

        "trov:generatedBySystem": { "@id": "trov:system/01" },
        "trov:fingerprint": fingerprint
    }]
}
json.dump(jsonld_content, fout, indent=4)

fout.close()
END_PYTHON
cat ${TRO_JSONLD_FILE}
END_CELL

# ------------------------------------------------------------------------------

bash_cell 'test different filenames: get fingerprint based on tro_fingerprint.py (directory)' << END_CELL

python3 tro_fingerprint.py -d ${MESSAGE_WITH_DIFF_FILENAMES_DIR}

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'test different filenames: get fingerprint based on tro_fingerprint.py (file)' << END_CELL

python3 tro_fingerprint.py -f ${MESSAGE_WITH_DIFF_FILENAMES_FILE}

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'test different filenames: get fingerprint based on tro_fingerprint.py (directory and file)' << END_CELL

python3 tro_fingerprint.py -d ${MESSAGE_WITH_DIFF_FILENAMES_SUBDIR} -f ${MESSAGE_WITH_DIFF_FILENAMES_FILE_WITHOUT_SUBDIR}

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'test different filenames: create tro manifest containing the digest of data (directory)' << END_CELL
python3 << END_PYTHON
from tro_fingerprint import compute_fingerprint
import json

fingerprint = compute_fingerprint(arg_dir="${MESSAGE_WITH_DIFF_FILENAMES_DIR}", arg_file=None)

fout = open("${TRO_JSONLD_FILE}", mode="w", encoding="utf-8")
jsonld_content = {
    "@context": [{
        "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
        "trov": "https://w3id.org/trace/2022/10/trov#"
    }],

    "@graph": [{

        "@id": "trov:tro/01",
        "@type": "trov:ResearchObject",

        "trov:generatedBySystem": { "@id": "trov:system/01" },
        "trov:fingerprint": fingerprint
    }]
}
json.dump(jsonld_content, fout, indent=4)

fout.close()
END_PYTHON
cat ${TRO_JSONLD_FILE}
END_CELL

# ------------------------------------------------------------------------------

bash_cell 'test different filenames: create tro manifest containing the digest of data (file)' << END_CELL
python3 << END_PYTHON
from tro_fingerprint import compute_fingerprint
import json

fingerprint = compute_fingerprint(arg_dir=None, arg_file="${MESSAGE_WITH_DIFF_FILENAMES_FILE}")

fout = open("${TRO_JSONLD_FILE}", mode="w", encoding="utf-8")
jsonld_content = {
    "@context": [{
        "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
        "trov": "https://w3id.org/trace/2022/10/trov#"
    }],

    "@graph": [{

        "@id": "trov:tro/01",
        "@type": "trov:ResearchObject",

        "trov:generatedBySystem": { "@id": "trov:system/01" },
        "trov:fingerprint": fingerprint
    }]
}
json.dump(jsonld_content, fout, indent=4)

fout.close()
END_PYTHON
cat ${TRO_JSONLD_FILE}
END_CELL

# ------------------------------------------------------------------------------

bash_cell 'test different filenames: create tro manifest containing the digest of data (directory and file)' << END_CELL
python3 << END_PYTHON
from tro_fingerprint import compute_fingerprint
import json

fingerprint = compute_fingerprint(arg_dir="${MESSAGE_WITH_DIFF_FILENAMES_SUBDIR}", arg_file="${MESSAGE_WITH_DIFF_FILENAMES_FILE_WITHOUT_SUBDIR}")

fout = open("${TRO_JSONLD_FILE}", mode="w", encoding="utf-8")
jsonld_content = {
    "@context": [{
        "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
        "trov": "https://w3id.org/trace/2022/10/trov#"
    }],

    "@graph": [{

        "@id": "trov:tro/01",
        "@type": "trov:ResearchObject",

        "trov:generatedBySystem": { "@id": "trov:system/01" },
        "trov:fingerprint": fingerprint
    }]
}
json.dump(jsonld_content, fout, indent=4)

fout.close()
END_PYTHON
cat ${TRO_JSONLD_FILE}
END_CELL

# ------------------------------------------------------------------------------