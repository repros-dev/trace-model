#!/usr/bin/env bash

CERTIFICATE_DIR=../common/certificate
TRO_DECLARATION_FILE=../common/tro-01-from-minimal-trs.jsonld
TRS_SIGNATURE_FILE=data/signature.asc
DIGEST_FILE=data/digest
TSQ_FILE=data/file.tsq
TSR_FILE=data/file.tsr




# ------------------------------------------------------------------------------

bash_cell 'Compute a digest for tro declaration and trs signature' << END_CELL

tro-fingerprint -f ${TRO_DECLARATION_FILE},${TRS_SIGNATURE_FILE} > ${DIGEST_FILE}

cat ${DIGEST_FILE}

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'Create a tsq file' << END_CELL

openssl ts -query -data ${DIGEST_FILE} -no_nonce -sha512 -cert -out ${TSQ_FILE}

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'Create a tsr file' << END_CELL

curl -H "Content-Type: application/timestamp-query" --data-binary '@${TSQ_FILE}' https://freetsa.org/tsr > ${TSR_FILE}

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'Verify the tsr' << END_CELL

openssl ts -verify -in ${TSR_FILE} -queryfile ${TSQ_FILE} -CAfile ${CERTIFICATE_DIR}/cacert.pem -untrusted ${CERTIFICATE_DIR}/tsa.crt

END_CELL

# ------------------------------------------------------------------------------
