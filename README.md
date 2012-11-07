git-growl
=========

Git hooks that provide local growl notifications

A project with admittedly limited practical uses, it does provide pretty, if largely redundant, git notifications. See the TODO section for when it could actually be useful.

Requirements
------------
On OSX, Git-growl needs [Growl](http://growl.info/) and growlnotify, which can be found in the extras for growl.

On Linux, Git-growl only needs libnotify, but loses any naming sense.

Installation
------------
For easy installation, just run the command below.
```sh
curl http://goo.gl/ltLch -L -o - | sh
```

Or, to install manually, checkout the repository in your home directory, changing the name to .git-growl.

Setup
-----
Navigate to the git repository you want to setup, then run
```sh
sh ~/.git-growl/install.sh
```
Or on Debian distros (or any distro that uses dash instead of bash as the default sh), run
```sh
bash ~/.git-growl/install.sh
```

TODO
----
* Add server side scripts to send notifications to clients (make this project useful!)
* Add an uninstall script
* Add a windows version

