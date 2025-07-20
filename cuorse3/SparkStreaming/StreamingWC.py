from pyspark.sql import SparkSession
from pyspark.sql import functions as f

if __name__ == "__main__":
    spark = SparkSession.builder.appName("File Streaming Demo") \
    .config("spark.streaming.stopGracefullyOnShutdown", "true") \
    .config("spark.sql.streaming.schemaInference","true") \
    .config("spark.sql.shuffle.partitions",3) \
    .getOrCreate()


    spark.conf.set("spark.sql.shuffle.partitions", 3)


    lines_df = spark.readStream \
        .format("json") \
        .option("path","input") \
        .load()
    
    lines_df.printSchema()

    address_df = lines_df.select("address")
    # address_df.printSchema()


    address_writer_query = address_df.writeStream \
        .format("json") \
        .option("path","output") \
        .outputMode("append") \
        .queryName("Get all address") \
        .option("checkpointLocation","chk-point-dir") \
        .trigger(processingTime = "1 minute") \
        .start()
    
    address_writer_query.awaitTermination()
        
    # word_count_query.awaitTermination()