import sys
if sys.version_info[0] < 3:
    from .NAFFlib2_c import *
else:
    from .NAFFlib_c import *

import numpy as np

def multiparticle_tunes(x):
    q_i = np.empty_like(x[:,0])
    for ii in range(len(x)):
        q_i[ii] = get_tune(x[ii])
    return q_i