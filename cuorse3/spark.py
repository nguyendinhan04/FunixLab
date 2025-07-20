from pyspark.sql import SparkSession
from pyspark.sql.types import StructType, StructField, StringType, IntegerType, DateType
from pyspark.sql.functions import spark_partition_id
from pyspark import SparkConf
from pyspark.sql.dataframe import DataFrame
from pyspark.sql import Row
spark = SparkSession.builder.appName("SparkSQL").getOrCreate()
# peopleDataFrame = spark.read\
#     .format("csv")\
#     .option("header","true")\
#     .option("inferSchema","true")\
#     .load("dataset.csv")

# peopleDataFrame.createOrReplaceTempView("myTMP")
# coun = spark.sql("select count(*) from myTMP")
# coun.show()

def mapper(line:str):
    fields = line.split(',')
    return Row(Name = fields[0],age = fields[1] ,addr = fields[2])

lines = spark.sparkContext.textFile("dataset.csv")
header = lines.first()
filtered_lines = lines.filter(lambda line: line != header)
ou = filtered_lines.collect()
people = filtered_lines.map(mapper)
print(ou)

myDataFrame = spark.createDataFrame(people)
myDataFrame.createOrReplaceTempView("myTMP")
names = spark.sql("select * from myTMP")

for name in names.collect():
    print(name)

names.show()
spark.stop()