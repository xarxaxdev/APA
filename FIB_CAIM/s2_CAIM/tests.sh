echo comp.os.ms-windows.misc
for file in ../test/comp.os.ms-windows.misc/* ; do
    python TFIDFViewer.py --index my_news --files ../test/comp.os.ms-windows.misc/0002413 $file 
    done

echo comp.windows.x

for file in ../test/comp.windows.x/* ; do
    #echo $file
    python TFIDFViewer.py --index my_news --files ../test/comp.os.ms-windows.misc/0002413 $file 
    done
    

echo baseball

for file in ../test/rec.sport.baseball/* ; do
   # echo $file
    python TFIDFViewer.py --index my_news --files ../test/comp.os.ms-windows.misc/0002413 $file 
    done
    
echo religion

for file in ../test/talk.religion/* ; do
    #echo $file
    python TFIDFViewer.py --index my_news --files ../test/comp.os.ms-windows.misc/0002413 $file 
    done
    

    
#    python TFIDFViewer.py --index my_news --files ../test/alt.atheism/0000000 ../test/alt.atheism/0000000 > bolcat.txt
#    python IndexFilesPreprocess.py --index my_news --path ../test --token standard
