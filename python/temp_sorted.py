guest=['mahesh','vaibhav','mohit']

for i in guest:
	print("Good Evening: "+i.title()+" Welcome")

print("*"*50)	
print(sorted(guest))

print("Non sorted")

print(guest)
guest.insert(0,'anand')
print(guest)
guest.insert(0,'znand')
print(guest)
guest.sort()
guest.reverse()
print(guest)


print("*"*40+'\n Revesing the order again')
guest.reverse()
print(guest)

