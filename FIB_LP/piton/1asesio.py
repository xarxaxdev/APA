#num_diferents (myli)
#	if(len (myli) == 0) return 0
#	return 1 + num_diferents(filter(lambda x:x == myli(0)  myli) )  


def absValue(x) :
	if x < 0 :
		return - x
	return x
	
def power(x, p):
	return x ** p


def isPrime(x):
	if x<2:
		return False
	for i in range (2,num): 
		if(num %i) ==0 :
			return False
	return True
