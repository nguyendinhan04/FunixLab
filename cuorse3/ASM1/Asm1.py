from pyspark.sql import functions as f
from pyspark.sql import SparkSession
from pyspark.sql.types import *

# spark-submit --packages org.mongodb.spark:mongo-spark-connector_2.12:3.0.1 Asm1.py   


spark = SparkSession.builder \
    .master("local") \
    .appName("ASM1_Spark") \
    .config('spark.jars.packages', 'org.mongodb.spark:mongo-spark-connector_2.12:3.0.1') \
    .config("spark.mongodb.read.connection.uri", "mongodb://127.0.0.1/ASM1_spark.Answers") \
    .config("spark.mongodb.write.connection.uri", "mongodb://127.0.0.1/ASM1_spark.Answers") \
    .config("spark.mongodb.read.connection.uri", "mongodb://127.0.0.1/ASM1_spark.Questitions") \
    .config("spark.mongodb.write.connection.uri", "mongodb://127.0.0.1/ASM1_spark.Questitions") \
    .config("spark.local.dir", r"C:\Users\dinha\OneDrive\Documents\FunixLab\cuorse3\ASM1\temp") \
    .getOrCreate()


# Answers_schema = StructType([
#     StructField("Body",StringType()),
#     StructField("CreationDate",StringType()),
#     StructField("Id",IntegerType()),
#     StructField("OwnerUserId", IntegerType()),
#     StructField("ParentId",IntegerType()),
#     StructField("Score",IntegerType()),
# ])

# Answers_df = spark.read \
#     .format("com.mongodb.spark.sql.DefaultSource") \
#     .option("uri","mongodb://localhost:27017/ASM1_spark") \
#     .option("collection","Answers") \
#     .schema(Answers_schema) \
#     .load()

# Answers_converted_df = Answers_df.withColumn("CreationDate", f.col("CreationDate").cast(DateType()))

# Answers_converted_df.printSchema()
# Answers_converted_df.show()


Questition_schema = StructType([
    StructField("Body",StringType()),
    StructField("CreationDate",StringType()),
    StructField("ClosedDate",StringType()),
    StructField("Id",IntegerType()),
    StructField("OwnerUserId", IntegerType()),
    StructField("title",StringType()),
    StructField("Score",IntegerType()),
])

Question_df = spark.read \
    .format("com.mongodb.spark.sql.DefaultSource") \
    .option("uri","mongodb://localhost:27017/ASM1_spark") \
    .option("collection","Questitions") \
    .schema(Questition_schema) \
    .load()

Questition_converted_schema = Question_df.withColumn("CreationDate", f.col("CreationDate").cast(DateType())) \
    .withColumn("ClosedDate",f.col("ClosedDate").cast(DateType())) \
    .withColumn("Body",f.lower("Body"))

Questition_converted_schema.printSchema()

count_word_per_record_df = Questition_converted_schema \
    .select(
    f.col("Id"),
    f.col("Body"), 
    f.regexp_count("Body" , f.lit(r"c\#")).alias(r"c#"),
    f.regexp_count("Body" , f.lit(r"c\+\+")).alias(r"c++"),
    f.regexp_count("Body" , f.lit(r"css")).alias(r"css"),
    f.regexp_count("Body" , f.lit(r"html")).alias(r"html"),
    f.regexp_count("Body" , f.lit(r"php")).alias(r"php"),
    f.regexp_count("Body" , f.lit(r"sql")).alias(r"sql"),
    f.regexp_count("Body" , f.lit(r"go")).alias(r"go"),
    f.regexp_count("Body" , f.lit(r"ruby")).alias(r"ruby"),
    f.regexp_count("Body" , f.lit(r"python")).alias(r"python"),
    f.regexp_count("Body" , f.lit(r"java")).alias(r"java")
    )


count_word_per_record_df.printSchema()
count_word_per_record_df.show(20)


total_count_df = count_word_per_record_df.agg(
    f.sum("c#").alias("C#"),
    f.sum("c++").alias("c++"),
    f.sum("css").alias("css"),
    f.sum("html").alias("html"),
    f.sum("php").alias("php"),
    f.sum("sql").alias("sql"),
    f.sum("go").alias("go"),
    f.sum("ruby").alias("ruby"),
    f.sum("python").alias("python"),
    f.sum("java").alias("java")
)


total_count_df.show()
