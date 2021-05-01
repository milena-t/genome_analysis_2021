import numpy as np
from math import *

def contig(T, e):
	N = 49639038
	c = 1256.282
	sig = 1-T/101
	E = N*e**(-c*sig)
	return E

for T in np.arange(30.0, 51.0, 5):
	for e in np.arange(70.0, 81.0, 1):
		print("T: "+str(T)+"; e: "+str(e))
		print(contig(T, e))

