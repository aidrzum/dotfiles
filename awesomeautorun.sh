#!/usr/bin/env bash

function run {
  if ! pgrep -f $1 ;
  then
    $@&
  fi
}



run mpd
run /usr/bin/sleep 2s && /home/rdia/Documents/scripz/hdmi.sh
run /usr/bin/nitrogen --restore
run /usr/bin/picom
run /usr/local/bin/fusuma
run /usr/bin/conky -c /home/rdia/.config/conky/rightconky.conf
run /usr/bin/xfce4-clipman
run nm-applet
run volumeicon
run xset r rate 550 60 &
run terminator
run /home/rdia/Documents/scripz/xinp.sh
run /usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1
#clipmenud



#run blueman-applet
#sleep 5s && conky --conf /home/rdia/.config/awesomeConky.conf --daemonize
#/opt/xinp.sh
#run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
#run fusuma --conf /home/rdia/.config/fusuma/awesomeCon
#compton --backend glx --blur-background --paint-on-overlay --glx-no-stencil --vsync opengl-swc --unredir-if-possible
