#!/usr/bin/env bash

# ------------------------------------------------------------------------------

bash_cell 'delete gnupg home directory' << 'END_CELL'

# delete contents of the .gnupg directory for this REPRO
gnupg-runtime.purge-keys

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'create gnupg home directory' << 'END_CELL'

# list the gpg keys to force creation of the gpg home directory
gpg --list-keys 2>&1

# show that the default keyring and trust database were created
echo
tree -a ${GNUPGHOME}

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'generate a key' << 'END_CELL'

gpg --batch --generate-key << END_GPG_INPUT
Key-Type: RSA
Key-Length: 1024
Name-Real: repro user
Name-Email: repro@repros.dev
Passphrase: repro
END_GPG_INPUT

# list the gpg keys
gpg --list-keys | grep uid

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'export the public key' << 'END_CELL'

# export the public key
gpg --export -a -o products/public.gpg repro@repros.dev

# print a redacted view of the public key
gnupg-runtime.redact-key products/public.gpg

END_CELL


# ------------------------------------------------------------------------------

bash_cell 'export the private key' << 'END_CELL'

# export the private key
gpg --export-secret-key -a --pinentry-mode loopback --passphrase=repro > products/private.asc

# print a redacted view of the private key
gnupg-runtime.redact-key products/private.asc

END_CELL

# ------------------------------------------------------------------------------
