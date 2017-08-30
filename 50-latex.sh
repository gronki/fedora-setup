#!/usr/bin/env bash

sudo dnf install \
texstudio bibutils \
texlive-collection-{langpolish,langenglish,fontsrecommended,fontsextra,htmlxml,science} \
texlive-{antt,datetime2-polish,glossaries-polish,mwcls} \
texlive-ams{cls,tex,math,refs} \
texlive-{mnras,astro,biblatex-phys} \
texlive-epsf \
texlive-{fira,droid,markdown,fontspec,mathspec,ctablestack,tex4ht}
