Mail configuration generation
=============================

### Motivation
Setting up `mutt` and the other tools needed to access your emails via the
command-line is a huge hassle. A lot of the configuration files are repetitive
and creating them by hand gets very frustrating if you have a lot of email
addresses.

This is a script designed to automate this setup process.

### What it does
* Configure [mutt][mutt]
* Configure [mbsync/isync][mbsync]
* Configure [msmtp][msmtp]
* Configure everything to use the [pass][pass] password store

### How to use it
To generate your configuration, you first have to supply the script your account
data. This is done by creating an `accounts` folder and putting account files
like this one in there:
```json
{
    "alias": "demo",
    "user": "user",
    "host": "mail.org",
    "imap": "imap.mail.org"
}
```
This file would represent the account `user@mail.org` aliased as `demo`. Note
that the *filename has to match the alias* or things could get ugly.

It is also recommended to now store your passwords in [pass][pass]. The password
for the account above would be stored under `email/demo`, all other accounts
follow this scheme.

Now that you've supplied all of your accounts, all that is left to do is running
the script:
```
$ ./genmail.sh
```

And it's done. You can retrieve the generated files from the `out/` folder. I
recommend using stow to link them into your home-directory.


[mutt]: http://www.mutt.org/
[mbsync]: http://isync.sourceforge.net/
[msmtp]: http://msmtp.sourceforge.net/
[pass]: http://www.passwordstore.org/
