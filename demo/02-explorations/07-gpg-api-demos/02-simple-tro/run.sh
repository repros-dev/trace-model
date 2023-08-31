#!/usr/bin/env bash

MESSAGE_FOLDER=data/message
PUBLIC_KEY_FILE=data/public.gpg
PRIVATE_KEY_FILE=data/private.asc
ZIPPED_MESSAGE_FILE=products/message.tar.gz
TRO_JSONLD_FILE=products/tro.jsonld
SIGNATURE_FILE=tmp/signature.asc

# ------------------------------------------------------------------------------

bash_cell 'delete the gnupg home directory and keys' << END_CELL
# delete contents of GnuPG home directory for this REPRO
gnupg-runtime.purge-keys
END_CELL

# ------------------------------------------------------------------------------

bash_cell 'tar the data dir content' << END_CELL

find | sort | tar -czvf ${ZIPPED_MESSAGE_FILE} ${MESSAGE_FOLDER} --mtime='1970-01-01'

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'create tro manifest containing the digest of data' << END_CELL
python3 << END_PYTHON
from hashlib import sha256
import json
with open("products/message.tar.gz", "rb") as fin:
    digest = sha256(fin.read()).hexdigest()
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
        "trov:digest": digest,
        "trov:troFilePath": "products/message.tar.gz"
    }]
}
json.dump(jsonld_content, fout, indent=4)

fout.close()
END_PYTHON
cat ${TRO_JSONLD_FILE}
END_CELL

# ------------------------------------------------------------------------------

bash_cell 'import the private key for repro@repros.dev' << END_CELL
python3 << END_PYTHON
import gnupg
# read the private key from the file
with open("${PRIVATE_KEY_FILE}", "r") as private_key_file:
    private_key_text = private_key_file.read()
# import the private key and trust it
gpg = gnupg.GPG()
gpg.import_keys(private_key_text)
gpg.trust_keys('BD4CA7A2E41893A79420976235AAF11171DB78A7', 'TRUST_ULTIMATE')
END_PYTHON
END_CELL

# ------------------------------------------------------------------------------

bash_cell 'list the imported public key using the gpg cli' << END_CELL
echo Public keys:
echo
gpg --list-keys
echo
echo Private keys:
echo
gpg --list-secret-keys
echo
END_CELL

# ------------------------------------------------------------------------------

bash_cell 'sign and verify the tro.jsonld for repro@repros.dev (detach=True)' << END_CELL
python3 << END_PYTHON
import gnupg
# Read the message from the file
with open("${TRO_JSONLD_FILE}", "r") as tro_jsonld_file:
    tro_jsonld_text = bytes(tro_jsonld_file.read(), "utf-8")
# Sign the message with the private key
gpg = gnupg.GPG()
signed_text = gpg.sign(tro_jsonld_text, keyid="repro@repros.dev", passphrase="repro", detach=True)
# Write the signed message to a file
with open("${SIGNATURE_FILE}", "w") as text_file:
    text_file.write(str(signed_text))
verified = gpg.verify_data("${SIGNATURE_FILE}", tro_jsonld_text)
if not verified: 
    raise ValueError("Signature could not be verified!")
else:
    print("Signature has been verified successfully!")
END_PYTHON
END_CELL

# ------------------------------------------------------------------------------