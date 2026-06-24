from pyspark.sql import SparkSession

spark = SparkSession.builder.appName("hive2mysql") \
  .config("spark.jars", "/usr/local/spark/jars/mysql-connector-java-8.0.30.jar") \
  .enableHiveSupport().getOrCreate()

jdbc_url = "jdbc:mysql://localhost:3306/dbtaobao"
jdbc_props = {"user":"spark","password":"123456789","driver":"com.mysql.cj.jdbc.Driver"}

def write_to_mysql(df, table, mode="overwrite"):
    df.write.mode(mode).format("jdbc") \
      .option("url", jdbc_url) \
      .option("user", "spark").option("password", "123456789") \
      .option("dbtable", table) \
      .option("driver", "com.mysql.cj.jdbc.Driver") \
      .save()
    print(f"  -> {table}: {df.count()} rows")

df = spark.sql("SELECT * FROM dbtaobao.user_log_full")
df.createOrReplaceTempView("ul")

print("[1] Computing agg_action...")
spark.sql("SELECT action, COUNT(*) num FROM ul GROUP BY action ORDER BY action").coalesce(1).write.mode("overwrite").format("jdbc").option("url",jdbc_url).option("user","spark").option("password","123456789").option("dbtable","agg_action").option("driver","com.mysql.cj.jdbc.Driver").save()

print("[2] Computing agg_gender...")
spark.sql("SELECT gender, COUNT(*) num FROM ul GROUP BY gender ORDER BY gender").coalesce(1).write.mode("overwrite").format("jdbc").option("url",jdbc_url).option("user","spark").option("password","123456789").option("dbtable","agg_gender").option("driver","com.mysql.cj.jdbc.Driver").save()

print("[3] Computing agg_gender_age...")
spark.sql("SELECT gender,age_range,COUNT(*) num FROM ul GROUP BY gender,age_range ORDER BY gender,age_range").coalesce(1).write.mode("overwrite").format("jdbc").option("url",jdbc_url).option("user","spark").option("password","123456789").option("dbtable","agg_gender_age").option("driver","com.mysql.cj.jdbc.Driver").save()

print("[4] Computing agg_cat_top5...")
spark.sql("SELECT cat_id,COUNT(*) num FROM ul GROUP BY cat_id ORDER BY num DESC LIMIT 5").coalesce(1).write.mode("overwrite").format("jdbc").option("url",jdbc_url).option("user","spark").option("password","123456789").option("dbtable","agg_cat_top5").option("driver","com.mysql.cj.jdbc.Driver").save()

print("[5] Computing agg_province...")
spark.sql("SELECT province,COUNT(*) num FROM ul GROUP BY province ORDER BY num DESC").coalesce(1).write.mode("overwrite").format("jdbc").option("url",jdbc_url).option("user","spark").option("password","123456789").option("dbtable","agg_province").option("driver","com.mysql.cj.jdbc.Driver").save()

print("[6] Computing agg_brand_top10...")
spark.sql("SELECT brand_id,COUNT(*) num FROM ul GROUP BY brand_id ORDER BY num DESC LIMIT 10").coalesce(1).write.mode("overwrite").format("jdbc").option("url",jdbc_url).option("user","spark").option("password","123456789").option("dbtable","agg_brand_top10").option("driver","com.mysql.cj.jdbc.Driver").save()

print("[7] Computing agg_merchant_top10...")
spark.sql("SELECT merchant_id,COUNT(*) num FROM ul GROUP BY merchant_id ORDER BY num DESC LIMIT 10").coalesce(1).write.mode("overwrite").format("jdbc").option("url",jdbc_url).option("user","spark").option("password","123456789").option("dbtable","agg_merchant_top10").option("driver","com.mysql.cj.jdbc.Driver").save()

print("[8] Computing agg_province_action...")
spark.sql("SELECT province,action,COUNT(*) num FROM ul GROUP BY province,action ORDER BY province,action").coalesce(1).write.mode("overwrite").format("jdbc").option("url",jdbc_url).option("user","spark").option("password","123456789").option("dbtable","agg_province_action").option("driver","com.mysql.cj.jdbc.Driver").save()

print("[9] Computing agg_age_action...")
spark.sql("SELECT age_range,action,COUNT(*) num FROM ul GROUP BY age_range,action ORDER BY age_range,action").coalesce(1).write.mode("overwrite").format("jdbc").option("url",jdbc_url).option("user","spark").option("password","123456789").option("dbtable","agg_age_action").option("driver","com.mysql.cj.jdbc.Driver").save()

print("[10] Computing agg_purchase_age_gender...")
spark.sql("SELECT age_range,gender,COUNT(*) num FROM ul WHERE action=2 GROUP BY age_range,gender ORDER BY age_range,gender").coalesce(1).write.mode("overwrite").format("jdbc").option("url",jdbc_url).option("user","spark").option("password","123456789").option("dbtable","agg_purchase_age_gender").option("driver","com.mysql.cj.jdbc.Driver").save()

print("[11] Computing agg_user_purchase_freq...")
spark.sql("SELECT cnt AS purchase_count,COUNT(*) AS user_num FROM (SELECT user_id,COUNT(*) cnt FROM ul WHERE action=2 GROUP BY user_id) t GROUP BY cnt ORDER BY cnt").coalesce(1).write.mode("overwrite").format("jdbc").option("url",jdbc_url).option("user","spark").option("password","123456789").option("dbtable","agg_user_purchase_freq").option("driver","com.mysql.cj.jdbc.Driver").save()

print("ALL AGGREGATION TABLES WRITTEN TO MYSQL!")
spark.stop()
