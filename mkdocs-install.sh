#!/bin/bash - 
#===============================================================================
#
#          FILE: mkdocs-install.sh
# 
#         USAGE: ./mkdocs-install.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 01/28/2020 07:02
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
mkdir ./venv
virtualenv ./venv/
. ./venv/bin/activate
pip3 install mkdocs 
pip3 install mkdocs-material
