#!/bin/bash
set -ex

# astrophotography reduction
sudo dnf install -y siril cpl sextractor

# ephemerides
sudo dnf install -y proas

# lovely ds9
sudo dnf copr enable -y gronki/saods9
sudo dnf install -y saods9

# astrometry
sudo dnf install -y scamp libnova

# variable stars
sudo dnf install -y nightfall xvarstar

# WCS handling
sudo dnf install -y ast

# planetarium sofware
sudo dnf install -y stellarium skychart{,-data-{stars,dso}} \
        starplot{,-contrib,-gliese3,-yale5} kstars

# FITS and other astro files
sudo dnf install -y pyfits cfitsio{,-devel} ATpy

# python libraries
sudo dnf install -y pyephem python2-{astropy,wcsaxes,APLpy,photutils}

# Google Earth
sudo dnf install -y marble-astro

# general utilities
sudo dnf install -y jday sunwait
