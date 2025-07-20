from pyspark.sql import SparkSession
from pyspark.sql.types import *
import pyspark.sql.functions as f

spark = SparkSession.builder.master("spark://spark-master:7077") \
    .config("spark.sql.catalogImplementation", "in-memory") \
    .config("spark.executor.pyspark.memory", "1g") \
    .config("spark.executor.cores","1") \
    .appName("transform_data").getOrCreate()


Answers_schema = StructType([
    StructField("Id",IntegerType()),
    StructField("OwnerUserId",IntegerType()),
    StructField("CreationDate",DateType()),
    StructField("ParentId",IntegerType()),
    StructField("Score",IntegerType()),
    StructField("Body",StringType())
])


Questions_schema = StructType([
    StructField("Id",IntegerType()),
    StructField("OwnerUserId",IntegerType()),
    StructField("CreationDate",DateType()),
    StructField("CloseDate",DateType()),
    StructField("Score",IntegerType()),
    StructField("Title",StringType()),
    StructField("Body",StringType())
])

Answers_df  = spark.read \
    .format("json") \
    .schema(Answers_schema) \
    .option("path","/usr/local/airflow/include/Answers.json") \
    .load()


Question_df = spark.read \
    .format("json") \
    .schema(Questions_schema) \
    .option("path","/usr/local/airflow/include/Questions.json") \
    .load()

Answers_df.show()

Question_df.show()

# join_expr = Answers_df.a == Question_df.c

# join_df = Answers_df.join(Question_df,join_expr,"right").groupBy(f.col("c")).agg(f.count("a"))

# join_df.show()



