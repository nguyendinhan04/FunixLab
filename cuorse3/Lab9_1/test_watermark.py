from pyspark.sql import SparkSession
from pyspark.sql import functions as f
from pyspark.sql.types import *
from pyspark.sql.window import *



spark = SparkSession.builder.appName("Lab9_1").config("spark.streaming.stopGracefullyOnShutdown","true").config("spark.sql.shuffle.partitions",3).getOrCreate()


schema = StructType([
    StructField("id",IntegerType()),
    StructField("time",StringType()),
    StructField("count",IntegerType())
])



kafka_df = spark.readStream \
    .format("kafka") \
    .option("kafka.bootstrap.servers","localhost:9092") \
    .option("subscribe","invoices") \
    .option("startingOffsets","earliest") \
    .load()

string_df = kafka_df.selectExpr("CAST(value AS STRING)")
value_df = string_df.select(f.from_json(f.col("value"),schema).alias("value"))
time_df = value_df.select(f.col("value.id").alias("id"),f.col("value.time").cast(TimestampType()).alias("time"),f.col("value.count").cast(IntegerType()).alias("count"))
time_df.printSchema()




test_groupby = time_df \
    .withWatermark("time","30 minute") \
    .groupBy(f.window(f.col("time"),"15 minute")) \
    .agg(f.sum("count").alias("total_count"))
test_groupby.printSchema()


test_groupby_writer = test_groupby.writeStream \
    .format("console") \
    .option("checkpointLocation","che-pon-dir") \
    .option("mode","append") \
    .start()

print("Waiting for Queries")
spark.streams.awaitAnyTermination()



# kafka_target_df = notification_df.select(f.col("InvoiceNumber").alias("key"), f.to_json(f.struct("CustomerCardNo","TotalAmount","EarnedLoyaltyPoints")).alias("value"))



# kafka_target_df.printSchema()

# notification_writer_query = kafka_target_df \
# 	.writeStream \
# 	.queryName("Notification Writer") \
# 	.format("kafka") \
# 	.option("kafka.bootstrap.servers", "localhost:9092") \
# 	.option("topic", "notifications") \
# 	.outputMode("append") \
# 	.option("checkpointLocation", "che-pon-dir-notification") \
# 	.start()


# print("Waiting for Queries")
# spark.streams.awaitAnyTermination()