#!/bin/csh
# 
# tauptime depth distance 
# where depth is in km and distance is in deg 
# 
# Calculates first S-wave arrival time in seconds 

taup_time -ph S -h $1 -deg $2 | awk '/ P / {print $4}' | awk 'NR ==1 {print $1}'
