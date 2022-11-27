Magisk module to disable app Analytics/Measurement/Firebase

- app measurement
- app analytics
- app firebase tracking
- app crashlytics

In short, each APK (system app or user app) may have background services to do all sorts of tracking and ad handling. 
Module allows you to disable (or enable) those services.

You must obviously be rooted and have a working Magisk.

How to install:

a) download attached zip file
b) push the zip file to your /sdcard folder (use: adb push dss.zip /sdcard)
c) open Magisk
d) in the panel at the bottom, tap the "modules" icon
e) at the top, select "install downloaded module"
f) navigate to your /sdcard folder
g) select dss.zip
h) tap the reboot button

After installation:
The script must be run manually using the command line. First, open a shell using adb:

> adb shell

then

> su

The script has the following syntax:

> dss {disable|enable} {user|system} <package-name>

You must provide 2 or 3 arguments to the script:
  
(a) first argument is "disable" or "enable" (by default Analytics/Firebase/etc services are enabled)
(b) second argument is "user" or "system" (use "user" for any app wich you installed using an APK or installed from play store; use "system" for apps which come as part of the official Google image, e.g. contacts/dialer/messaging)
(c) the third argument is optional and - if present - contains the name of a specific package (e.g. com.banking.mybankapp)

Examples:

1) disable analytics/firebase/etc for ALL user apps
> dss disable user
2) enable analytics/firebase/etc for ALL system apps (this is the default)
> dss enable system
3) disable analytics/firebase/etc for Feedly
> dss disable user com.devhd.feedly

The script will show you output of the services which get disabled, for example for the Feedly case:

> Component {com.devhd.feedly/com.facebook.internal.FacebookInitProvider} new state: disabled
> Component {com.devhd.feedly/com.google.android.gms.analytics.AnalyticsJobService} new state: disabled
> Component {com.devhd.feedly/com.google.android.gms.analytics.AnalyticsReceiver} new state: disabled
> Component {com.devhd.feedly/com.google.android.gms.analytics.AnalyticsService} new state: disabled

Occasionally it can happen that after disabling Analytics/Firebase/etc, the app no longer works. 
Then just "enable" again. Apps should - in principle - be resilient but some are not coded properly. 
Alternatively, you can try to figure out exactly which of the services causes the crash and (manuall) 
re-enable that service (but you will need to look into the source code a bit). 
When you run this on Feedly for example, you will find that it crashes afterwards 
(reason is that the script disabled com.devhd.feedly/com.facebook.internal.FacebookInitProvider). 
You can re-enable that service individually using:

> pm enable com.devhd.feedly/com.facebook.internal.FacebookInitProvider

or just do:

> dss enable user com.devhd.feedly
(that will re-enable all the services previously disabled)

You can also disable stuff for system apps, e.g. com.android.contacts (Contacts), com.android.vending (Play store app), etc ...
However, one BIG WARNING. If you disable this for system apps, make sure to re-run the script with the 
'enable system' argument BEFORE running a Play-systemupdate otherwise that may bootloop. 
So, to be on the safe side, if you have used the script to disable services in system APKs, then run:

> dss enable system

before doing the Play-systemupdate.

I you want to check the source code (simple sh script), just unzip the dss.zip in a new directory and check out the file system/bin/dss. 
It's not complicated ...

This will save you (a tiny litte bit) of battery, but more importantly, a lot of nasty "tracking" (which you don't need).

Changes are persistent across reboots.
