number=list(range(1,20))
print(number)

for i in number:
	j=list(range(i,i*11,i))
	for j_i in j:
		print(j_i,end=''+'\t')
	print()

