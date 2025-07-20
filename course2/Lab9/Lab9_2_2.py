from random import randint as rnd
from pprint import pprint as pp
memReg = r'Lab9/members.txt'
exReg = r'Lab9/inactive.txt'
fee =('yes','no')

def genFiles(current,old):
    with open(current,'w+') as writefile: 
        writefile.write('Membership No  Date Joined  Active  \n')
        data = "{:^13}  {:<11}  {:<6}\n"

        for rowno in range(20):
            date = str(rnd(2015,2020))+ '-' + str(rnd(1,12))+'-'+str(rnd(1,25))
            writefile.write(data.format(rnd(10000,99999),date,fee[rnd(0,1)]))


    with open(old,'w+') as writefile: 
        writefile.write('Membership No  Date Joined  Active  \n')
        data = "{:^13}  {:<11}  {:<6}\n"
        for rowno in range(3):
            date = str(rnd(2015,2020))+ '-' + str(rnd(1,12))+'-'+str(rnd(1,25))
            writefile.write(data.format(rnd(10000,99999),date,fee[1]))


# genFiles(memReg,exReg)




def cleanFiles(currentMem,exMem):
    '''
    currentMem: File containing list of current members
    exMem: File containing list of old members
    
    Removes all rows from currentMem containing 'no' and appends them to exMem
    '''
    with open(currentMem,"r+") as cur:
        cur.readline()
        lines = cur.readlines()
        curMem = []
    with open(exMem, "a+") as ex:
        for line in lines:
                active = line[28:31]
                if(active.rstrip() == "no"):
                    ex.write(line)
                    print(line)
                else:
                    curMem.append(line)
    with open (currentMem, "w") as cur:
        cur.write("Membership No  Date Joined  Active  \n")
        for line in curMem:
            cur.write(line)
                    
    pass 


# # Code giúp bạn thấy file
# # Để như sau
# memReg = r'Lab9/members.txt'
# exReg = r'Lab9/inactive.txt'
# cleanFiles(memReg,exReg)


# headers = "Membership No  Date Joined  Active  \n"
# with open(memReg,'r') as readFile:
#     print("Active Members: \n\n")
#     print(readFile.read())
    
# with open(exReg,'r') as readFile:
#     print("Inactive Members: \n\n")
#     print(readFile.read())



# Tset
def testMsg(passed):
    if passed:
       return 'Test Passed'
    else :
       return 'Test Failed'

testWrite = "testWrite.txt"
testAppend = "testAppend.txt" 
passed = True

genFiles(testWrite,testAppend)

with open(testWrite,'r') as file:
    ogWrite = file.readlines()

with open(testAppend,'r') as file:
    ogAppend = file.readlines()

try:
    cleanFiles(testWrite,testAppend)
except:
    print('Error')

with open(testWrite,'r') as file:
    clWrite = file.readlines()

with open(testAppend,'r') as file:
    clAppend = file.readlines()
        
# kiểm tra xem không có bất kỳ hàng nào giống nhau, bao gồm tiêu đề

if (len(ogWrite) + len(ogAppend) != len(clWrite) + len(clAppend)):
    print("The number of rows do not add up. Make sure your final files have the same header and format.")
    passed = False
    
for line in clWrite:
    if  'no' in line:
        passed = False
        print("Inactive members in file")
        break
    else:
        if line not in ogWrite:
            print("Data in file does not match original file")
            passed = False
print ("{}".format(testMsg(passed)))