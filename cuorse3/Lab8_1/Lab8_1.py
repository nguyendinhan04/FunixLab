
from pyspark.sql import functions as f
from pyspark.sql.types import *
from pyspark.sql import SparkSession

if __name__ == "__main__":
    spark = SparkSession.builder.appName("lab8_1") \
        .config("spark.sql.shuffle.partitions",3) \
        .config("spark.streaming.stopGracefullyOnShutdown","true") \
        .config("spark.sql.streaming.schemaInference","true") \
        .getOrCreate()
    

    raw_df = spark.readStream \
        .format("json") \
        .option("path","input") \
        .option("maxFilesPerTrigger","1") \
        .option("cleanSource","delete") \
        .load()
    
    # raw_df.printSchema()
    # raw_df.show()

    parse_df = raw_df.selectExpr("explode(InvoiceLineItems) as value")
    parse_invoiceLineItems_df = parse_df.selectExpr("value.ItemCode as `ItemCode`"," value.ItemDescription as `ItemDescription`", "value.ItemPrice as `ItemPrice`", "value.ItemQty as `ItemQty`", "value.TotalValue as `TotalValue`")
    parse_invoiceLineItems_df.printSchema()


    invoiceWriterQuery = parse_invoiceLineItems_df.writeStream \
	.format("json") \
	.queryName("Flattened Invoice Writer") \
	.outputMode("append") \
	.option("path", "output") \
	.option("checkpointLocation", "chk-point-dir") \
    .trigger(processingTime = "20 second") \
	.start()

print("Flattened Invoice Writer started")
invoiceWriterQuery.awaitTermination()


