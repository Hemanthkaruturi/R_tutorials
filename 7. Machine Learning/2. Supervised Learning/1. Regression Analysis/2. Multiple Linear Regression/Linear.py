#Importing libraries
import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

#Importing data
data = pd.read_csv('fs1_training.csv')
data.columns

#Pre processing data
data = data[['time_stamp','Sector 1','Sector 2','Sector 4','Sector 3']]
data.head()
data.dtypes
data['time_stamp_month'] = data['time_stamp'].str.slice(0,7,1)
data.head()

#Summarizing data to month wise
data1 = data[['Sector 1','Sector 2','Sector 4','Sector 3','time_stamp_month']].groupby(['time_stamp_month']).mean()
data1 = data1.reset_index()
data1.head()

#convert time stamp to numeric
data1['time_stamp_month'] = data1['time_stamp_month'].str.replace('-','')
data1['time_stamp_month'] = data1['time_stamp_month'].astype('int')


#visualization
sns.scatterplot(x=data['time_stamp_month'], y=data['Sector 3'])
sns.scatterplot(x=data1['time_stamp_month'], y=data1['Sector 3'])

#taking features and target
data1.head()
X = data1.iloc[:,0:4].values
y = data1.iloc[:,4].values

# Splitting the dataset into the Training set and Test set
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.2, random_state = 0)

#Applying regression models
# Fitting Multiple Linear Regression to the Training set
from sklearn.linear_model import LinearRegression
regressor = LinearRegression()
regressor.fit(X_train, y_train)

# Predicting the Test set results
y_pred = regressor.predict(X_test)

#RMSE
print(np.sqrt((np.sum(y_test - y_pred)**2)/len(y_test)))
#66.35589734418745
