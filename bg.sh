#!/bin/bash

FILE=$(ls ~/Documents/Backgrounds/ | shuf -n 1)


gsettings set org.gnome.desktop.background picture-uri file:///home/adam/Documents/Backgrounds/$FIL
