# Ghi dòng vào file
exmp2 = 'Example2.txt'
# with open(exmp2, 'w') as writefile:
#     writefile.write("This is line A")

# with open(exmp2, 'r') as testwritefile:
#     print(testwritefile.read())

# with open(exmp2, 'w') as writefile:
#     writefile.write("This is line A\n")
#     writefile.write("This is line B\n")

# Lines = ["This is line A\n", "This is line B\n", "This is line D\n"]

# with open('Example2.txt', 'w') as writefile:
#     for line in Lines:
#         print(line)
#         writefile.write(line)

# with open('Example2.txt', 'a') as testwritefile:
#     testwritefile.write("This is line C\n")
#     testwritefile.write("This is line D\n")
#     testwritefile.write("This is line E\n")


# with open('Example2.txt','r') as readfile:
#     with open('Example3.txt','w') as writefile:
#           for line in readfile:
#                 writefile.write(line)

# with open('Example2.txt', 'a+') as testwritefile:
#     testwritefile.write("This is line E\n")
#     print(testwritefile.read())


with open('Example2.txt', 'a+') as testwritefile:
    print("Initial Location: {}".format(testwritefile.tell()))
    
    data = testwritefile.read()
    if (not data):  #empty strings return false in python
            print('Read nothing') 
    else: 
            print(testwritefile.read())
            
    testwritefile.seek(0,0) # move 0 bytes from beginning.
    
    print("\nNew Location : {}".format(testwritefile.tell()))
    data = testwritefile.read()
    if (not data): 
            print('Read nothing') 
    else: 
            print(data)
    
    print("Location after read: {}".format(testwritefile.tell()) )

# with open("Example2.txt", "r") as file1:
#        print(file1.tell())

