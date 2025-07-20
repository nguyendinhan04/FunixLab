from pyspark.sql import SparkSession, Window
from pyspark.sql.functions import from_json, col, to_timestamp, window, expr
from pyspark.sql import functions as f
from pyspark.sql.types import StructType, StructField, StringType, IntegerType,TimestampType

spark = SparkSession.builder.config("spark.streaming.stopGracefullyOnShutdown","true").appName("Lab10_1").config("spark.sql.shuffle.partitions",2).getOrCreate()


schema = StructType([
    StructField("CreatedTime",StringType()),
    StructField("Type",StringType()),
    StructField("Amount",IntegerType()),
    StructField("BrokerCode",StringType())
])


kafka_df = spark.readStream \
    .format("kafka") \
    .option("kafka.bootstrap.servers","localhost:9092") \
    .option("startingOffsets","earliest") \
    .option("subscribe","trades") \
    .load()



value_df = kafka_df.select(col("value").cast(StringType())).withColumn("value",from_json(col("value"),schema=schema))
extracted_df = value_df.selectExpr("value.*")
# extracted_df.printSchema()

trade_df = extracted_df.withColumn("CreatedTime",col("CreatedTime").cast(TimestampType())) \
        .withColumn("BUY", expr("case when Type = 'BUY' then Amount else 0 end")) \
        .withColumn("SELL", expr("case when Type = 'SELL' then Amount else 0 end"))
# trade_df.printSchema()

window_agg_df = trade_df \
    .groupBy(window(col("CreatedTime"),"15 minute")) \
    .agg(f.sum("BUY").alias("TotalBuy"),f.sum("SELL").alias("TotalSell"))

output_df = window_agg_df.select("window.start","window.end","TotalBuy","TotalSell")

window_df_writer = output_df.writeStream \
    .format("console") \
    .outputMode("update") \
    .option("checkpointLocation", "che-pon-dir") \
    .trigger(processingTime="1 minute") \
	.start()

print("Waiting for Query")
window_df_writer.awaitTermination()

# spark-submit --packages org.apache.spark:spark-streaming-kafka-0-10_2.12:3.5.3,org.apache.spark:spark-sql-kafka-0-10_2.12:3.5.3 Lab10_1.py