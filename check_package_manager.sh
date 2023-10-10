#!/usr/bin/env bash

if (which rpm &>/dev/null); then
	item_rpm=1
	echo "You have the rpm utility."
else
	item_rpm=0
fi

if (which flatpak &>/dev/null); then
	item_flatpak=1
	echo "You have the flatpak application container."
else
	item_flatpak=0
fi
