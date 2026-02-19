This repo contains auxiliary teaching and assignment resources for Digital Biology, a grad/undergrad bioinformatics course taught at Indiana University.

# Troubleshooting Notes
Here we will compile topics flagged in class as confusing, challenging, or that lead to computer errors.

### `CTRL` + `f` on Windows
To search for some text inside your git bash window, if CTRL-F doesn't work try right clicking and then click "Search".

### File paths
File paths are a little tricky at first.
- Assignment 2 "Part I" is designed for practicing file paths. You can do it again for practice.
- The online Hendrix text (link under Module 1 on canvas) provides further reading.
- If you still have trouble come to office hours.

### GitHub Classroom account setup
Check your email from GH, that link tends to work instead of the auto-generated one.

### Keyboard doesn't communicate with shell as expected
- Research Desktop. The keyboard shortcuts we use don't work in Research Desktop. And in general we want to wean off the Research Desktop and use a basic shell.
- Non-US computer. We may or may not be able to troubleshoot this. First, come to office hours and we can try changing your settings. Alternatively, email biocomp@iu.edu to borrow a computer.

### `nano`
- **How to undo?** `EST` + `u` (at least with macbook).
- **How to ctrl-F on Windows?** `ctrl-W` should do it.

### HPC login without username and full address
On your laptop run `mkdir -p ~/.ssh; touch .ssh/config`. And then copy this code block into the terminal, replacing "chriscs" with your username:
```
cat <<'EOF' >> ~/.ssh/config
Host bigred
     HostName bigred200.uits.iu.edu
     User chriscs
Host quartz
     HostName quartz.uits.iu.edu
     User chriscs
EOF
```
Now you should be able to SSH with `ssh quartz` instead of the full command (not certain if this works on Windows.)


### HPC login without password
1. Submit the [SSH Key Agreement Form](https://uitsradl-fireform.eas.iu.edu/online/form/authen/sshkeyagreement?_gl=1*8qqlu3*_gcl_au*MTQzNjQzNDk1NS4xNzY1MjA1NzQ1*_ga*NDE0MjE5Njc3LjE3NTQwNjE5MDI.*_ga_61CH0D2DQW*czE3Njk3OTE2MTUkbzY0JGcwJHQxNzY5NzkxNjE1JGo2MCRsMCRoMA..), in which you agree to set a passphrase on your private key when you generate your key pair.
2. On your laptop run: `ssh-keygen -t rsa`. Press `ENTER` to accept default file path. When prompted for a password type in the new password you want to use to login; if you press `ENTER` without typing anything, this means no password.
3. Next copy your "key" to Quartz (or BigRed): `scp ~/.ssh/id_rsa.pub <username>@quartz.uits.iu.edu:~/`
4. Log into Quartz (or BigRed).
5. Run `mkdir -p ~/.ssh; touch ~/.ssh/authorized_keys; cat ~/id_rsa.pub >> ~/.ssh/authorized_keys`
6. Finally, run `rm ~/id_rsa.pub`

That should do it for macbook (not certain if this works on Windows). More info here: https://servicenow.iu.edu/kb?id=kb_article_view&sysparm_article=KB0023919

### SCP
Most often the trick is to give correct file paths on both ends. Resources:
- see description in Assignment 2, Part I, Step 7.
- see failure modes in the posted slides from class. 
- see more [examples and edge cases here](https://linuxblog.io/linux-securely-copy-files-using-scp/).

### Where to store my data on Quartz/BigRed?
Class project? -> `/N/slate/`  (long term storage for intermediate-sized files)

Assignments? -> `/N/slate/` is fine. Scratch is also fine if your run out of space, but it gets deleted after 30 days.

Temporary files? -> `/N/scratch/`


