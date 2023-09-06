#!/usr/bin/env bash

TRO_DATA_DIR=data
TRO_DATA_RUN_DIR=run
TRO_EXE_SCRIPT=test.py
FINGERPRINT_STATE_BEFORE_FILE=products/before.csv
FINGERPRINT_STATE_AFTER_FILE=products/after.csv
FINGERPRINT_STATE_FILE=products/fingerprint_state.csv

# ------------------------------------------------------------------------------

bash_cell 'Copy all files under the data folder to the run folder' << END_CELL

cp -rf ${TRO_DATA_DIR} ${TRO_DATA_RUN_DIR}

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'fingerprint state before running the code' << END_CELL

tro_fingerprint_state -d ${TRO_DATA_RUN_DIR} -f ${TRO_EXE_SCRIPT} -c before -o ${FINGERPRINT_STATE_BEFORE_FILE}

cat ${FINGERPRINT_STATE_BEFORE_FILE}

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'execute python script' << END_CELL

python3 ${TRO_EXE_SCRIPT}

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'fingerprint state after running the code' << END_CELL

tro_fingerprint_state -d ${TRO_DATA_RUN_DIR} -f ${TRO_EXE_SCRIPT} -c after -o ${FINGERPRINT_STATE_AFTER_FILE}

cat ${FINGERPRINT_STATE_AFTER_FILE}

END_CELL

# ------------------------------------------------------------------------------


bash_cell 'fingerprint state' << END_CELL

merge_states -f ${FINGERPRINT_STATE_BEFORE_FILE},${FINGERPRINT_STATE_AFTER_FILE} -o ${FINGERPRINT_STATE_FILE}

cat ${FINGERPRINT_STATE_FILE}

END_CELL

# ------------------------------------------------------------------------------
