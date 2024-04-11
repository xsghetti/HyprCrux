#!/bin/bash

swaync-client -rs &
swaync-client -R
pkill ags
