from pyspark.sql import SparkSession




spark = SparkSession.builder.appName("transform_data").getOrCreate()

data  = [(1,2,3),(4,5,6)]

data_df = spark.createDataFrame(data,["col1","col2","col3"])
repartition_df = data_df.repartition(1)

repartition_df.show()

repartition_df.write \
    .format('csv') \
    .option('path','/usr/local/airflow/include/spark_script/output') \
    .mode('overwrite') \
    .save()