#!/usr/bin/env bash

# Reset the out directory
rm -rf out
mkdir out

# Get all the account names
accs=$(ls -C accounts)
read -a accs_arr <<< "$accs"

# Create the mailboxes
for acc in $accs
do
    mkdir -p ~/.mail/$acc/INBOX
done

# Create the .mbsyncrc
for acc in $accs
do
    ./apply-template.py templates/mbsyncrc accounts/$acc >> out/.mbsyncrc
done

# Create msmtprc
cp defaults/msmtprc out/.msmtprc
for acc in $accs
do
    ./apply-template.py templates/msmtprc accounts/$acc >> out/.msmtprc
done

# Create mutt configuration
cp -r defaults/mutt out/.mutt

# Default to the first mailbox
echo "set spoolfile = \"+${accs_arr[0]}/INBOX\"" >> out/.mutt/muttrc
echo "source ~/.mutt/accs/${accs_arr[0]}" >> out/.mutt/muttrc

mkdir out/.mutt/accs
for acc in $accs
do
    ./apply-template.py templates/mutt_account accounts/$acc > out/.mutt/accs/$acc
    echo "folder-hook $acc/* source ~/.mutt/accs/$acc" >> out/.mutt/muttrc
done

echo "Generated your configuration to $PWD/out"
