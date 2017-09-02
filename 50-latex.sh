#!/usr/bin/env bash

sudo dnf install bibutils \
texlive-collection-{langpolish,langenglish,science} \
texlive-{antt,datetime2-polish,glossaries-polish,mwcls} \
texlive-ams{cls,tex,math,refs} \
texlive-{mnras,astro,biblatex-phys} \
texlive-{epsf,ctablestack,tex4ht}
sudo dnf install texstudio
