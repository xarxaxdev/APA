#/opt/elasticsearch-5.4.1/bin/elasticsearch -Epath.conf=ESconf & 
#python IndexFiles.py --index novels --path ./novels
# python SearchIndex.py --index news --query good AND evil
#python CountWords.py --index novels > caca.txt
#g++ -o filtro filtro.cpp -std=c++0x
#./filtro  < caca.txt > limpio.txt
#python plotter.py  < limpio.txt > result.txt
python plotter2.py  < limpio.txt > result2.txt
