#!/usr/bin/python

from collections import defaultdict
import time
import sys


edgeHash = defaultdict(int) # hash of edge to ease the match,w(i,j)
airportHash = dict() # hash key IATA code -> Airport
airportOutWeight=defaultdict(int) #out(j)
DAMPING = 1



def readAirports(fd):
    print "Reading Airport file from {0}".format(fd)
    airportsTxt = open(fd, "r");
    cont = 0
    for line in airportsTxt.readlines():
        line = line.split(',')
        if(len(line[4])!= 5):#skip nonIATA
            #print line
            continue
        airportHash[line[4][1:-1]]=line[1]
        cont+=1
    airportsTxt.close()
    print "There were {0} Airports with IATA code".format(cont)


def readRoutes(fd):
    print "Reading Routes file from {0}".format(fd)
    # write your code
    routesTxt = open(fd, "r");
    cont = 0
    for line in routesTxt.readlines():
        line = line.split(',')
        airportfrom = line[2]#3rd position is origin airport code
        airportto = line[4]#5th posistion  is destination IATA code
        if len(airportfrom) != 3 or len(airportto) != 3 or airportfrom not in airportHash or airportto not in airportHash:
            #skipe routes that involve nonIATA, or that involve airports we don't consider
            continue

        #changes to w(i,j)
        edgeHash[(airportfrom, airportto)] += 1
        #changes to out(j)
        airportOutWeight[airportfrom]+=1

        cont +=1


    routesTxt.close()
    print "There were {0} Routes with IATA code".format(cont)






def computePageRanks():
    # write your code
    n=len(airportHash)
    P= dict(zip(airportHash.keys(),[1./n] * n))
    Q =P.copy()
    iterations=10000
    x=0
    iter_damping=(1.-DAMPING )/n
    while x<iterations:
        for orig,dest in edgeHash:
            if(airportOutWeight[orig]==0):
                print "This shouldn't ever happen"
                continue
            Q[dest] += P[orig]*edgeHash[(orig,dest)]/airportOutWeight[orig]
            Q[orig] -= P[orig]*edgeHash[(orig,dest)]/airportOutWeight[orig]
        for key in Q:
            Q[key] =  DAMPING*Q[key]  +iter_damping
        x +=1
        #if notdifferentenough(P,Q,iter_damping):
            #return x,P
        P= Q.copy()
    return (iterations,P)


def outputPageRanks(P):
    P = sorted(P.items(), key = lambda x : x[1],reverse=True)
    for airport,value in P:
        print  airportHash[airport] +str(value)

def notdifferentenough(P,Q,value):
    for val in P:
        if abs(P[val] -Q[val]) > value :
            return False
    return True

def main(argv=None):
    readAirports("airports.txt")
    readRoutes("routes.txt")
    time1 = time.time()
    (iterations,P) = computePageRanks()
    time2 = time.time()
    outputPageRanks(P)
    print "#Iterations:", iterations
    print "Time of computePageRanks():", time2-time1


if __name__ == "__main__":
    sys.exit(main())
