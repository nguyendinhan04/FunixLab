# import urllib.request
# url = 'https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMDeveloperSkillsNetwork-PY0101EN-SkillsNetwork/labs/Module%204/data/example1.txt'
# filename = 'Example1.txt'
# urllib.request.urlretrieve(url, filename)

example1 = "Example1.txt"
print("helo")
file1 = open(example1, "r")
print(file1.mode)
FileContent = file1.read()
print(FileContent)
print(type(FileContent))
file1.close()

with open(example1, "r") as file1:
    FileContent = file1.read()
    print(FileContent)
print(file1.closed)

with open("example1.txt", "r") as file1:
    print(file1.read(4))

with open(example1, "r") as file1:
    print(file1.read(4))
    print(file1.read(4))
    print(file1.read(7))
    print(file1.read(15))


with open(example1, "r") as file1:
    print(file1.read(16))
    print(file1.read(5))
    print(file1.read(9))

with open(example1, "r") as file1:
    print("first line: " + file1.readline(200))

with open(example1, "r") as file1:
    print(file1.readline(20))
    print(file1.read(20)) 

with open(example1, "r") as file1:
    FileasList = file1.readlines()
    print(FileasList)


with open(example1,"r") as file1:
        i = 0;
        for line in file1:
            print("Iteration", str(i), ": ", line)
            i = i + 1
