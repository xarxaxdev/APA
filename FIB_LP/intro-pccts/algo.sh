#./bin/bash

echo "Hello world"

echo "/opt/pccts/bin/antlr -gt "$1".g"
/opt/pccts/bin/antlr -gt $1.g
echo "/opt/pccts/bin/dlg -ci parser.dlg scan.c"
/opt/pccts/bin/dlg -ci parser.dlg scan.c

echo "g++ -o "$1" " $1".c scan.c err.c -I/home/soft/PCCTS_v1.33/include/ -Wno-write-strings"
g++ -o $1 $1.c scan.c err.c -I/home/soft/PCCTS_v1.33/include/ -Wno-write-strings
echo "executing program"
./$1 
#echo "cleaning"
#rm -f *.o example1.c scan.c err.c parser.dlg tokens.h mode.h 
