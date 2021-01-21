#!/bin/bash
if [ -n "$5" ]
then
cat <<EOF > $1.sh
#!/bin/bash
let GW=$2;
let GH=$3;

adb shell settings put global overlay_display_devices \${GW}x\${GH}/200;
let PhoneDisplay=\$(scrcpy -V error --display=255 | grep -so "\-\-display [0-9]*" | grep -v "\-\-display 0" | grep -o "[0-9]*");
adb shell wm size reset -d \$PhoneDisplay;
adb shell am start-activity --windowingMode 6 --display \$PhoneDisplay $4/$5; scrcpy --display \$PhoneDisplay --window-title $1 --crop \$GW:\$GH:0:40 && adb shell settings put global overlay_display_devices none && adb shell input keyevent HOME
EOF

chmod +x $1.sh

else
echo "+--------------------- gravitos' scrcpy app-cast utility v1.0 -----------------+"
echo "|     Usage: 	${0} WindowName Width Height Package Activity       |"
echo "+------------------------------------------------------------------------------+"
echo "	WindowName: name of the window to be displayed in title bar"
echo " 	    Height: height of app window and of the virtual screen that will be"
echo "	            used"
echo "	            Take note that 40px at the top will be cut to immerse" 
echo "	            android titlebar with linux one"
echo "	     Width: width of app window and of the virtual screen that will be"
echo "	            used"
echo "	   Package: package name of the app, e.g. com.android.launcher3"
echo "	  Activity: name of the activity that will be started."
echo "	            Not all activities are supported."
echo "Usage example: ${0} Trebuchet 480 800 com.android.launcher3 .activity.MainActivity"
fi
