#!/usr/bin/env bash

if grep "$USER" /etc/passwd; then
	echo "This user exists..."
	echo "bye.."
fi

echo "Checking root user..."

if grep "$ROOT" /etc/passwd; then
	echo "This user exists..."
	echo "bye.."
fi

echo "Checking a non-existing user..."
non_user=evil_user
if grep "$non_user" /etc/passwd; then
	echo "This user exists..."
	echo "bye.."
else
	echo "This user $non_user does NOT exist!"
fi
