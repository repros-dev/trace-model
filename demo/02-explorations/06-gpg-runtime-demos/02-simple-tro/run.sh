#!/usr/bin/env bash

MESSAGE_FOLDER=data/message
PUBLIC_KEY_FILE=data/public.gpg
PRIVATE_KEY_FILE=data/private.asc
ZIPPED_MESSAGE_FILE=products/message.tar.gz
TRO_JSONLD_FILE=products/tro.jsonld
DIGEST_FILE=products/digest.txt
SIGNATURE_FILE=tmp/signature.asc

# ------------------------------------------------------------------------------

bash_cell 'delete gnupg home directory' << 'END_CELL'
# delete contents of the .gnupg directory for this REPRO
gnupg-runtime.purge-keys
END_CELL

# ------------------------------------------------------------------------------

bash_cell 'tar the data dir content' << END_CELL

tar -czvf ${ZIPPED_MESSAGE_FILE} ${MESSAGE_FOLDER} --mtime='1970-01-01'

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'create tro certificate containing the digest of data' << END_CELL

# Create tro.jsonld
cat > ${TRO_JSONLD_FILE} << EOF
{
    "@context": [{
        "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
        "trov": "https://w3id.org/trace/2022/10/trov#"
    }],

    "@graph": [{

        "@id": "trov:tro/01",
        "@type": "trov:ResearchObject",

        "trov:generatedBySystem": { "@id": "trov:system/01" },
        "trov:digest": "$(shasum -a 256 products/message.tar.gz | cut -d" " -f 1)",
        "trov:troFilePath": "products/message.tar.gz"
    }]
}
EOF

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'import jsonld' << END_CELL

# Import TRO as JSON-LD and export as N-TRIPLES
geist destroy --dataset kb --quiet
geist create --dataset kb --infer owl --quiet
geist import --format jsonld --file ${TRO_JSONLD_FILE}

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'create a tmp file to verify the digest' << 'END_CELL'

# Note: there must be exactly two spaces between the hash and the file path
DIGEST_FILE=products/digest.txt
geist report > ${DIGEST_FILE} << 'END_TEMPLATE'
    {{ prefix "trov" "https://w3id.org/trace/2022/10/trov#" }}             \\
                                                                           \\
    {{ range $Digest := select '''
        SELECT DISTINCT ?hash ?filePath
        WHERE {
            ?tro   trov:digest  ?hash .
            ?tro   trov:troFilePath ?filePath .
        }                                                                   \\
        ''' | rows }}                                                       \\
                                                                             \\
        {{ index $Digest 0 }}  {{ index $Digest 1 }}                          \\
    {{ end }}                                                                
END_TEMPLATE
cat ${DIGEST_FILE}
END_CELL

# ------------------------------------------------------------------------------

bash_cell 'verify the digest using shasum' << END_CELL

shasum -a 256 -c ${DIGEST_FILE}

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'import the private key for repro@repros.dev' << END_CELL
# delete contents of the .gnupg directory for this REPRO
gnupg-runtime.purge-keys
# import the private key file
gpg --import --pinentry-mode loopback --passphrase=repro ${PRIVATE_KEY_FILE} 2>&1
echo
# list the gpg keys
gpg --list-keys
END_CELL

# ------------------------------------------------------------------------------

bash_cell 'sign the tro.jsonld file with the private key' << END_CELL

rm -f ${SIGNATURE_FILE}
gpg --detach-sign --local-user repro@repros.dev \
    --pinentry-mode loopback --passphrase=repro \
    -a -o ${SIGNATURE_FILE}             \
    ${TRO_JSONLD_FILE} 2>&1
gnupg-runtime.redact-key ${SIGNATURE_FILE}

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'verify the signature with the public key' << END_CELL

gpg -v --verify ${SIGNATURE_FILE} ${TRO_JSONLD_FILE} 2>&1 | tail -6

END_CELL

# ------------------------------------------------------------------------------