from pyspark.sql import SparkSession
from pyspark.sql import functions as f
from pyspark.sql.types import StringType,IntegerType


spark =  SparkSession.builder.appName("ASM2") \
    .config("spark.mongodb.read.connection.uri", "mongodb://root:example@mongodb:27017/admin") \
    .config("spark.mongodb.write.connection.uri", "mongodb://root:example@mongodb:27017/admin") \
    .config("spark.mongodb.write.maxBatchSize", "100") \
    .config("spark.sql.shuffle.partitions", "5") \
    .getOrCreate()


Answers_df = spark.read \
    .format("mongodb") \
    .option("database", "admin") \
    .option("collection", "ASM2_Answers") \
    .load()
project_Answers_df = Answers_df.select(f.col("Id").alias("Answer_id"), f.col("ParentId").alias("Answer_ParentId"))

Answer_question_df = project_Answers_df.groupBy("Answer_ParentId").agg(f.count("Answer_id").alias("Number_of_Answers"))


Questions_df = spark.read \
    .format("mongodb") \
    .option("database", "admin") \
    .option("collection", "ASM2_Questions") \
    .load()
project_Questions_df = Questions_df.select(f.col("Id").alias("ParentId"))



join_expr = Answer_question_df.Answer_ParentId == project_Questions_df.ParentId

ouput_df = project_Questions_df.join(Answer_question_df, join_expr, "left").select("ParentId", "Number_of_Answers")

ouput_df.write \
    .format("mongodb") \
    .mode("Append") \
    .option("database", "admin") \
    .option("collection", "ASM2_output") \
    .save()


# ouput_df.write \
#     .format("csv") \
#     .mode("Overwrite") \
#     .option("path","/usr/local/airflow/include/ouput") \
#     .save()