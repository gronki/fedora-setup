#!/usr/bin/env bash

sudo dnf install -y bibutils texstudio \
	texlive-collection-langpolish \
	texlive-ams{cls,tex,math,refs} \
	texlive-{epsf,dvipng-bin,ctablestack,tex4ht,sttools} \
	texlive-ulem
