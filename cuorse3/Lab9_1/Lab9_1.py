from pyspark.sql import SparkSession
from pyspark.sql import functions as f
from pyspark.sql.types import *



spark = SparkSession.builder.appName("Lab9_1").config("spark.streaming.stopGracefullyOnShutdown","true").getOrCreate()


schema = StructType([
	StructField("InvoiceNumber", StringType()),
	StructField("CreatedTime", LongType()),
	StructField("StoreID", StringType()),
	StructField("PosID", StringType()),
	StructField("CashierID", StringType()),
	StructField("CustomerType", StringType()),
	StructField("CustomerCardNo", StringType()),
	StructField("TotalAmount", DoubleType()),
	StructField("NumberOfItems", IntegerType()),
	StructField("PaymentMethod", StringType()),
	StructField("CGST", DoubleType()),
	StructField("SGST", DoubleType()),
	StructField("CESS", DoubleType()),
	StructField("DeliveryType", StringType()),
	StructField("DeliveryAddress", StructType([
		StructField("AddressLine", StringType()),
		StructField("City", StringType()),
		StructField("State", StringType()),
		StructField("PinCode", StringType()),
		StructField("ContactNumber", StringType())
	])),
	StructField("InvoiceLineItems", ArrayType(StructType([
		StructField("ItemCode", StringType()),
		StructField("ItemDescription", StringType()),
		StructField("ItemPrice", DoubleType()),
		StructField("ItemQty", IntegerType()),
		StructField("TotalValue", DoubleType())
	]))),
])



kafka_df = spark.readStream \
    .format("kafka") \
    .option("kafka.bootstrap.servers","localhost:9092") \
    .option("subscribe","invoices") \
    .option("startingOffsets","earliest") \
    .load()
string_df = kafka_df.selectExpr("CAST(value AS STRING)")
value_df = string_df.select(f.from_json(f.col("value"),schema).alias("value"))
notification_df = value_df.select("value.InvoiceNumber", "value.CustomerCardNo", "value.TotalAmount") \
	.withColumn("EarnedLoyaltyPoints", f.expr("TotalAmount * 0.2"))

# notification_df.printSchema()

kafka_target_df = notification_df.select(f.col("InvoiceNumber").alias("key"), f.to_json(f.struct("CustomerCardNo","TotalAmount","EarnedLoyaltyPoints")).alias("value"))
# kafka_target_df.printSchema()

notification_writer_query = kafka_target_df \
	.writeStream \
	.queryName("Notification Writer") \
	.format("kafka") \
	.option("kafka.bootstrap.servers", "localhost:9092") \
	.option("topic", "notifications") \
	.outputMode("append") \
	.option("checkpointLocation", "che-pon-dir-notification") \
	.start()



explode_df = value_df.selectExpr("value.InvoiceNumber", "value.CreatedTime", "value.StoreID",
									"value.PosID", "value.CustomerType", "value.PaymentMethod", "value.DeliveryType",
									"value.DeliveryAddress.City",
									"value.DeliveryAddress.State", "value.DeliveryAddress.PinCode",
									"explode(value.InvoiceLineItems) as LineItem")



flattened_df = explode_df \
	.withColumn("ItemCode", f.expr("LineItem.ItemCode")) \
	.withColumn("ItemDescription", f.expr("LineItem.ItemDescription")) \
	.withColumn("ItemPrice", f.expr("LineItem.ItemPrice")) \
	.withColumn("ItemQty", f.expr("LineItem.ItemQty")) \
	.withColumn("TotalValue", f.expr("LineItem.TotalValue")) \
	.drop("LineItem")


# Ghi dữ liệu dưới dạng File Sink
invoice_writer_query = flattened_df.writeStream \
	.format("json") \
	.queryName("Flattened Invoice Writer") \
	.outputMode("append") \
	.option("path", "output") \
	.option("checkpointLocation","che-pon-dir-invoice") \
	.start()



print("Waiting for Queries")
spark.streams.awaitAnyTermination()

# spark-submit --packages org.apache.spark:spark-streaming-kafka-0-10_2.12:3.5.3  Lab9_1.py

# spark-submit --packages org.apache.spark:spark-streaming-kafka-0-10_2.12:3.5.3  Lab9_1.py

# spark-submit --packages org.apache.spark:spark-streaming-kafka-0-10_2.12:3.5.3,org.apache.spark:spark-sql-kafka-0-10_2.12:3.5.3 Lab9_1.py
