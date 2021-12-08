# Windows Server and Domain Controller Images

This repo contains source files for building Windows Server and Active Directory images that can be used with Instruqt.

* Based on GCE windows-2019
* Installs [Myrtille](https://myrtille.io) (Apache 2.0 license) for HTML5 RDP access
* Enables OpenSSH
* Installs Edge

## Remote Desktop via Browser

Myrtille is an HTML5 Remote Access Gateway, enable RDP from any browser.

To access RDP or SSH sessions use the following settings:

* RDP
  * Port: 80
  * Path: `/Myrtille/?__EVENTTARGET=&__EVENTARGUMENT=&user=<username>&password=<password>&connect=Connect%21`
* SSH
  * Port: 80
  * Path: `/Myrtille/?__EVENTTARGET=&__EVENTARGUMENT=&hostType=1&user=<username>&password=<password>&connect=Connect%21` (note added `hostType=1` parameter)

See [Myrtille Docs](https://github.com/cedrozor/myrtille/blob/master/DOCUMENTATION.md#auto-connect--start-remote-application-from-url) for more auto connect options.
