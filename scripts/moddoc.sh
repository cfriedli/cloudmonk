#!/bin/bash - 
#===============================================================================
#
#          FILE: moddoc.sh
# 
#         USAGE: ./moddoc.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 01/28/2020 07:21
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
rm ../docs/modules.md
for id in $(cat all_mods) ; do 
   echo "#### $id" >> ../docs/modules.md; 
   echo '```yaml' >> ../docs/modules.md ;  
   ansible-doc -s $id >> ../docs/modules.md ; 
   echo '```' >> ../docs/modules.md ; 
done


