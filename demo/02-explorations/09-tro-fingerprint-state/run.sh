#!/usr/bin/env bash

TRO_PAYLOAD_DIR=data
TRO_EXE_SCRIPT=data/test.py
FINGERPRINT_STATE_BEFORE_FILE=products/before.csv
FINGERPRINT_STATE_AFTER_FILE=products/after.csv
FINGERPRINT_STATE_FILE=products/fingerprint_state.csv


# ------------------------------------------------------------------------------

bash_cell 'fingerprint state before running the code' << END_CELL

tro_fingerprint_state -d ${TRO_PAYLOAD_DIR} -c before -o ${FINGERPRINT_STATE_BEFORE_FILE}

cat ${FINGERPRINT_STATE_BEFORE_FILE}

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'execute python script' << END_CELL

python3 ${TRO_EXE_SCRIPT}

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'fingerprint state after running the code' << END_CELL

tro_fingerprint_state -d ${TRO_PAYLOAD_DIR} -c after -o ${FINGERPRINT_STATE_AFTER_FILE}

cat ${FINGERPRINT_STATE_AFTER_FILE}

END_CELL

# ------------------------------------------------------------------------------


bash_cell 'fingerprint state' << END_CELL

merge_states -f ${FINGERPRINT_STATE_BEFORE_FILE},${FINGERPRINT_STATE_AFTER_FILE} -o ${FINGERPRINT_STATE_FILE}

cat ${FINGERPRINT_STATE_FILE}

END_CELL

# ------------------------------------------------------------------------------
