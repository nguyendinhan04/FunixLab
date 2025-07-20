from pyspark.sql import SparkSession

#create simple spark session and job 
spark = SparkSession.builder.appName("SimpleApp") \
    .config("spark.mongodb.read.connection.uri", "mongodb://root:example@mongodb:27017/admin") \
    .config("spark.mongodb.write.connection.uri", "mongodb://root:example@mongodb:27017/admin") \
    .getOrCreate()

# Dữ liệu mẫu
data = [(1,2), (3,4), (5,6)]

# Sử dụng SparkContext để parallelize
df = spark.sparkContext.parallelize(data).toDF(["col1", "col2"])

# Hiển thị DataFrame
df.show()


# df.write \
#     .format("mongodb") \
#     .mode("Append") \
#     .option("database", "admin") \
#     .option("collection", "test") \
#     .save()

# Dừng SparkSession
spark.stop()