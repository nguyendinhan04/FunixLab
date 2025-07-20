import pandas as pd
csv_path = 'https://s3-api.us-geo.objectstorage.softlayer.net/cf-courses-data/CognitiveClass/PY0101EN/Chapter%204/Datasets/TopSellingAlbums.csv'
df = pd.read_csv(csv_path)
print(df)

q = df[['Rating']]
print(q)


q = df[['Released', 'Artist']]
print(q)

q = df.iloc[1, 2]
print(q)