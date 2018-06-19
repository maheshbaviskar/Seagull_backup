import subprocess
import time


file=open("data_file.txt","r")
for line in file:
	fields=line.split(",")
	fileds1=fields[0]
	fileds2=fields[01]	
	print(fileds1 +" "+ fileds2)
	subprocess.call(['./pcef-data.sh'])
	time.sleep(2)
