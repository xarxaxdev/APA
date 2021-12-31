#!/usr/bin/env python
"""
Simple module implementing LSH
"""

from __future__ import print_function, division
import pylab
import numpy
import sys
import argparse
import time
import itertools

__version__ = '0.2'
__author__  = 'xarxax.dev@gmail.com'

data = []

def timeit(method):

    def timed(*args, **kw):
        ts = time.time()
        result = method(*args, **kw)
        te = time.time()

        print ('%r (%r, %r) %2.2f sec' % \
              (method.__name__, args, kw, te-ts))
        return result

    return timed

def hamming(a, b):
    return bin(a^b).count('1')

def distance(img1,img2):
    res= 0
    for pix1,pix2 in zip(itertools.chain(*img1),itertools.chain(*img2)):
        res += hamming(int(pix1),int(pix2))
        #print(res)
    return res

def brute_force_search(img2search):
    global data
    min = 999999
    answer = data[0]
    for idx, im in enumerate(data[:1500]):
        dist = distance(img2search,im)
        if dist < min:
            min=dist
            answer = idx
    return min,answer

@timeit
def main(argv=None):
    global data
    data = numpy.load('images.npy')

    # show candidate neighbors for first 10 test images
    for r in range(1500,1510):
        im = data[r]
        topcand = brute_force_search(im)
        print("the closest image to "+str(r) +" is " + str(topcand[1]))
        print("its humming distance being " + str(topcand[0]))
    return

if __name__ == "__main__":
  sys.exit(main())
