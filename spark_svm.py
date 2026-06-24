from pyspark import SparkContext
from pyspark.mllib.regression import LabeledPoint
from pyspark.mllib.linalg import Vectors
from pyspark.mllib.classification import SVMWithSGD
from pyspark.sql import SparkSession, Row
from pyspark.sql.types import StructType, StructField, StringType

spark = SparkSession.builder.appName("svm_rebuy") \
  .config("spark.jars", "/usr/local/spark/jars/mysql-connector-java-8.0.30.jar") \
  .getOrCreate()

sc = spark.sparkContext

print("[1/5] Reading train_after.csv from HDFS...")
train_data = sc.textFile("/dbtaobao/dataset/train_after.csv")
test_data = sc.textFile("/dbtaobao/dataset/test_after.csv")
print(f"  train: {train_data.count()}, test: {test_data.count()}")

print("[2/5] Parsing data...")
def parse(line):
    parts = line.split(',')
    return LabeledPoint(float(parts[4]), Vectors.dense(float(parts[1]), float(parts[2]), float(parts[3])))

train = train_data.map(parse)
test = test_data.map(parse)

print("[3/5] Training SVM model...")
numIterations = 1000
model = SVMWithSGD.train(train, numIterations)
print("  Model trained!")

print("[4/5] Predicting...")
model.clearThreshold()
def predict(point):
    score = model.predict(point.features)
    return str(score) + " " + str(point.label)

scoreAndLabels = test.map(predict)
print("  Predictions done!")

print("[5/5] Writing to MySQL rebuy table...")
schema = StructType([
    StructField("score", StringType(), True),
    StructField("label", StringType(), True)
])
rows = scoreAndLabels.map(lambda x: Row(x.split(" ")[0].strip(), x.split(" ")[1].strip()))
df = spark.createDataFrame(rows, schema)
df.write.mode("overwrite").format("jdbc") \
  .option("url", "jdbc:mysql://localhost:3306/dbtaobao") \
  .option("user", "spark").option("password", "123456789") \
  .option("dbtable", "rebuy") \
  .option("driver", "com.mysql.cj.jdbc.Driver") \
  .save()
print(f"  Written {df.count()} rows to MySQL rebuy!")
print("ALL DONE!")
spark.stop()
