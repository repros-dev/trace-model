#!/usr/bin/env bash

# ------------------------------------------------------------------------------

bash_cell 'generate a key pair' << END_CELL

# delete contents of GnuPG home directory for this REPRO
gnupg-runtime.purge-keys

# generate a new key pair
python3 << END_PYTHON

import gnupg
import os

gpg = gnupg.GPG()
key_settings = gpg.gen_key_input(
    key_type = 'RSA',
    key_length = 1024,
    name_real = 'repro user',
    name_email = 'repro@repros.dev',
    passphrase = 'repro'
)
key = gpg.gen_key(key_settings)

END_PYTHON

# list the gpg keys
gpg --list-keys | grep uid

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'export the public key' << 'END_CELL'

PUBLIC_KEY_FILE=products/public.pgp

python3 << END_PYTHON

import gnupg

# export the public key
gpg = gnupg.GPG()
public_key = gpg.export_keys('repro@repros.dev')

# write the public key to a file
with open("products/public.pgp", "w") as text_file:
    text_file.write(public_key)

END_PYTHON

# print a redacted view of the public key
gnupg-runtime.redact-key ${PUBLIC_KEY_FILE}

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'export the private key' << 'END_CELL'

# export the private key
PRIVATE_KEY_FILE=products/private.asc

python3 << END_PYTHON

import gnupg

# export the public key
gpg = gnupg.GPG()
private_key = gpg.export_keys('repro@repros.dev', secret=True, passphrase='repro')

# write the private key to a file
with open("products/private.asc", "w") as text_file:
    text_file.write(private_key)

END_PYTHON

# print a redacted view of the private key
gnupg-runtime.redact-key ${PRIVATE_KEY_FILE}

END_CELL

# ------------------------------------------------------------------------------
