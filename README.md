# scrcpy-appcast
A little appcast script for scrcpy

This script is created for users who always wanted to see some of their android apps from phone on their Linux PCs. UPD: Works on Cygwin too, if you install scrcpy.exe and adb.exe into cygwin's /bin. Screenshots are in assets - because github's markdown does not allow to resize images on-the-go, what a shame.

Limitations:
User can only open one app at a time.
Changing window size will not result in changing application size.
Only Android 10+ are supported.
Only English keyboard layout is available (this is scrcpy's fault, not mine)

This uses virtual screens to work and it needs no root.
I AM NOT RESPONSIBLE FOR BROKEN DEVICES AND LOST DATA. You have been warned.

# Installation

Step 1. You need https://github.com/Genymobile/scrcpy and its dependencies. Consider installing it according to scrcpy's README.

Step 2. You should go to Developer Options on your phone and turn on "Force desktop mode", "Force activities to be resizeable" and "Enable freeform windows". This may break Android 11's default screen recorder.

Step 3. Using https://play.google.com/store/apps/details?id=de.szalkowski.activitylauncher or its alternatives, find your preferred Activity to launch with app. Remember Package and Class field contents (Class is the Activity).

Step 4. Run create-app.sh:
```bash
$ chmod +x ./create-app.sh
$ ./create-app.sh WindowName Width Height Package Activity
```
	WindowName: name of the window to be displayed in title bar
 	    Height: height of app window and of the virtual screen that will be
	            used
	            Take note that 40px at the top will be cut to immerse
	            android titlebar with linux one
	     Width: width of app window and of the virtual screen that will be
	            used
	   Package: package name of the app, e.g. com.android.launcher3
	  Activity: name of the activity that will be started.
	            Not all activities are supported.
Usage example: `./create-app.sh Trebuchet 480 800 com.android.launcher3 .activity.MainActivity`

Step 5. Connect your phone to your PC using adb (either by usb cable or by `adb connect ip:port`)

Step 6. Run `./WindowName.sh` where WindowName is name you specified when using `create-app.sh`. You should see a little window on your phone's top left corner. Move it whereever you want. After ~2 seconds you will see Activity from step 3 on your PC.

# Flaws

If you detach your phone BEFORE closing the app window on laptop, phone keeps virtual screen existing. You can go to dev options and set virtual screens manually or connect your phone to your PC again and run `adb shell settings put global overlay_display_devices none`.
Sometimes opening the app causes it to be non-fullscreen on virtual screen. Sadly, I can do nothing about it.
