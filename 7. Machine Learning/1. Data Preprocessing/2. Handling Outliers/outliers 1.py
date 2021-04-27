import pandas as pd
import numpy as np
import seaborn as sns
from scipy import stats
import os
os.chdir('C:/Users/600037209/Documents/Classes/Data')

# reading the Boston data
df = pd.read_csv("Boston_housing_train.csv")

#Explore data
df.head()
df.shape

#check datatypes
df.dtypes

#univariate analysis
df.columns
sns.boxplot(x = df['medv'])

sns.distplot(df['medv'])

#Bivariate analysis
sns.scatterplot(x=df['medv'],y=df['tax'])

#remove outliers using z score
z = np.abs(stats.zscore(df))
z
threshold = 3
print(np.where(z > 3))
df.columns

df_new = df[(np.abs(stats.zscore(df)) < threshold).all(axis=1)]
#observer data after removing outliers
sns.boxplot(x=df_new['zn'])
sns.scatterplot(x=df_new['medv'],y=df_new['tax'])

# remove outliers using IQR
Q1 = df.quantile(0.25)
Q3 = df.quantile(0.75)
IQR = Q3 - Q1
print(IQR)
df.shape
df_out = df[~((df < (Q1 - 1.5 * IQR)) |(df > (Q3 + 1.5 * IQR))).any(axis=1)]
df_out.shape
#observer after removing outliers
sns.boxplot(x=df_out['medv'])
sns.scatterplot(x=df_out['medv'],y=df_out['tax'])


# remove outliers which are out at standard deviations
df_std = df[np.abs(df.medv-df.medv.mean()) <= (df.medv.std())]
## do it same for all the variables

#observe the values
sns.boxplot(x=df_std['medv'])
sns.scatterplot(x=df_new['medv'],y=df_new['tax'])
