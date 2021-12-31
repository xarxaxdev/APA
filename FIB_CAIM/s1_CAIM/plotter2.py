
import matplotlib.pyplot as plt
from math import log 

#valores x= rango y = frequencia

#a=1
#b=1
#c=1
a=0.975
b=30
c=0.1375

def f(rank):
    #if rank == 15000:
     #   rank = 15001
    return c/((float(rank) + b )**a)
    

if __name__ == '__main__':
    limpio = open('limpio.txt', 'r')
    #frequencia absoluta de palabras
    axisx=[]
    freq=limpio.readline()
    copy =[]
    while (freq != ''):
        axisx.append(float(freq))
        word=limpio.readline()
        freq=limpio.readline()
    limpio.close()
    #total es el numero total de palabras, sirve para la frequencia relativa
    total=sum(axisx)
    #diferentes es el numero de palabras diferentes
    diferentes=len(axisx)
    #reverse
    axisx=axisx[::-1]
    #creamos vector de ids para poder plotear bien
    ids =[]
    n=1
    for i in axisx:
        ids.append(n)
        n=n+1
        
    #frequencia relativa de palabras
    freqrel=[]
    for i in axisx:
        freqrel.append(float(i)/float(total))

    #frecuencia con Zipfs
    fzips= []
    for i in ids:
        fzips.append(f(i))
    
    
    plt.xlabel('id')
    plt.ylabel('freq')
    plt.plot(ids,fzips,'ro',freqrel,'bo')
    plt.yscale('linear')
    plt.xscale('linear')
    plt.axis([0,4000,0,0.0006])
    plt.show()
