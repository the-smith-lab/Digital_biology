# Troubleshooting Notes
Here we will compile topics flagged in class as confusing, challenging, or that lead to computer errors.

[link to Screenshots from Poll Everywhere](https://docs.google.com/document/d/13oLcTltJeTbUQqVc598iFtIgqPRfr4raEcISe_85Xj0/edit?tab=t.0)

### `CTRL` + `f` on Windows
To search for some text inside your gish bash window, if CTRL-F doesn't work try right clicking and then "Search"

### GitHub Classroom account setup
Check your email from GH, that link tends to work instead of the auto-generated one.

### Keyboard doesn't communicate with shell as expected
Working on this...

### `nano`
**How to undo?** `EST` + `u` should do it at least with macbook. 

**How to ctrl-F on Windows?** `ctrl-W` should do it.

### password-less login to HPC
1. Submit the ["SSH public key authentication to HPS systems" agreement](["SSH public key authentication to HPS systems" agreement](https://uitsradl-fireform.eas.iu.edu/online/form/authen/sshkeyagreement?_gl=1*18ivnqi*_gcl_au*MTQzNjQzNDk1NS4xNzY1MjA1NzQ1*_ga*NDE0MjE5Njc3LjE3NTQwNjE5MDI.*_ga_61CH0D2DQW*czE3Njk3OTE2MTUkbzY0JGcwJHQxNzY5NzkxNjE1JGo2MCRsMCRoMA..)), in which you agree to set a passphrase on your private key when you generate your key pair.
2. On your laptop run: `ssh-keygen -t rsa`. Press `ENTER` to accept default file path. When prompted for a password type in the new password you want to use to login; if you press `ENTER` without typing anything, this means no password.
3. Next copy your "key" to Quartz (or BigRed) `scp ~/.ssh/id_rsa.pub <username>@quartz.uits.iu.edu:~/`
4. Log into Quartz (or BigRed).
5. Run `mkdir -p ~/.ssh; touch ~/.ssh/authorized_keys; cat ~/id_rsa.pub >> ~/.ssh/authorized_keys`

That should do it. More info here: https://servicenow.iu.edu/kb?id=kb_article_view&sysparm_article=KB0023919

### SCP
Resources:
- description in Assignment 2, Part I, Step 7.
- see [examples and edge cases here](https://linuxblog.io/linux-securely-copy-files-using-scp/).

### Where to store my data on Quartz/BigRed?
Class project? -> `/N/slate/`  (long term storage for intermediate-sized files)

Assignments? -> `/N/slate/` is fine. Scratch is also fine if your run out of space but gets deleted.

Temporary files? -> `/N/scratch/`


