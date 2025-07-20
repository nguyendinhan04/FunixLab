from pyspark.sql import SparkSession
from pyspark.sql import functions as f
from pyspark.sql.types import *


def file_filter(file_name):
    return file_name.startwith("context_batch")

if __name__ == "__main__":
    spark = SparkSession.builder.appName("File Streaming Demo") \
    .config("spark.streaming.stopGracefullyOnShutdown", "true") \
    .config("spark.sql.streaming.schemaInference","true") \
    .config("spark.sql.shuffle.partitions",3) \
    .getOrCreate()


    spark.conf.set("spark.sql.shuffle.partitions", 3)

    df_schema = StructType([
        StructField("name", StringType()),
        StructField("address", StringType()),
        StructField("dat",StringType())
    ])

    lines_df = spark.readStream \
        .format("json") \
        .option("path","input") \
        .schema(df_schema) \
        .option("latestFirst", "true") \
        .option("maxFilesPerTrigger", 1) \
        .option("cleanSource", "DELETE") \
        .load()
    
    lines_df.printSchema()

    address_df = lines_df.select("address")
    # address_df.printSchema()

    # filter_df = address_df.filter(f.input_file_name().like("test"))
    # filter_df = address_df.withColumn(f.split(f.input_file_name(),"/").alias("file_name"))
    filter_df = address_df.withColumn("File_name",f.split(f.input_file_name(),"/").getItem(12))

    filter_df.printSchema()
    address_writer_query = filter_df.writeStream \
        .format("json") \
        .option("path","output") \
        .outputMode("append") \
        .queryName("Get all address") \
        .option("checkpointLocation","chk-point-dir") \
        .trigger(processingTime = "5 second") \
        .start()
    
    address_writer_query.awaitTermination()