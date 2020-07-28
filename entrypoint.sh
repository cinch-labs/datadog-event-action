#!/bin/sh -l

echo "Hello $1 - cinch"
time=$(date)
echo "::set-output name=time::$time"