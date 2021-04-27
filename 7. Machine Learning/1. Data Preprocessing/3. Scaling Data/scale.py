import pandas as pd
import numpy as np
import os
os.chdir('C:/Users/600037209/Documents/Classes/Data')

# reading the big mart sales training data
df = pd.read_csv("Boston_housing_train.csv")

df.head()

#manual standardization
df_scale = pd.DataFrame()
df_scale['crim'] = (df['crim'] - df['crim'].mean())/np.std(df['crim'])
# do it same for all the variables

#manual normalization
df_norm = pd.DataFrame()
df_norm['crim'] = (df['crim'] - min(df['crim'])) / (max(df['crim'] - min(df['crim'])))
# do it same for all the variables

#standardization using sklearn package
from sklearn import preprocessing
df_standard = preprocessing.scale(df)
names = df.columns
df_standard = pd.DataFrame(df_standard, columns=names)
df_standard

#normalization using sklearn
from sklearn import preprocessing
df_normal = preprocessing.normalize(df)
df_normal = pd.DataFrame(df_normal, columns=names)
df_normal
