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


#visualization
sns.scatterplot(x=data['time_stamp_month'], y=data['Sector 3'])
sns.scatterplot(x=data1['time_stamp_month'], y=data1['Sector 3'])

#convert time stamp to numeric
data1['time_stamp_month'] = data1['time_stamp_month'].str.replace('-','')
data1['time_stamp_month'] = data1['time_stamp_month'].astype('int')


#taking features and target
data1.head()
X = data1.iloc[:,0:4].values
y = data1.iloc[:,4].values

# Splitting the dataset into the Training set and Test set
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.2, random_state = 0)

# # Feature Scaling
# from sklearn.preprocessing import StandardScaler
# sc_X = StandardScaler()
# X_train = sc_X.fit_transform(X_train)
# X_test = sc_X.transform(X_test)
# sc_y = StandardScaler()
# y_train = sc_y.fit_transform(y_train.reshape(-1,1))

#Applying regression models
# Fitting Random Forest Regression to the dataset
from sklearn.ensemble import RandomForestRegressor
regressor = RandomForestRegressor(n_estimators = 10, random_state = 0)
regressor.fit(X, y)
regressor.feature_importances_
# Predicting a new result
y_pred = regressor.predict(X_test)

#RMSE
y
X_test
print(np.sqrt((np.sum(y_test - y_pred)**2)/len(y_test)))
#7.762197409789786

#Applying on test data
test_data = pd.read_csv('fs1_test.csv')
#Pre processing data
data = test_data[['serial_number','time_stamp','Sector 1','Sector 2','Sector 4']]
data.head()
data.dtypes
data['time_stamp_month'] = data['time_stamp'].str.slice(0,7,1)
data.head()

#Summarizing data to month wise
data1 = data[['Sector 1','Sector 2','Sector 4','time_stamp_month']].groupby(['time_stamp_month']).mean()
data1 = data1.reset_index()
data1.tail()

#convert time stamp to numeric
data1['time_stamp_month'] = data1['time_stamp_month'].str.replace('-','')
data1['time_stamp_month'] = data1['time_stamp_month'].astype('int')
data1.head()
test_data_1 = data1.iloc[:,0:4].values

y_test_pred = regressor.predict(test_data_1)

time_list = []
value_list = []
for time,values in zip(data['time_stamp_month'].unique(),list(y_test_pred)):
    #print(time,values)
    time_list.append(time)
    value_list.append(values)

final_df = pd.DataFrame()
final_df['time_stamp'] = time_list
final_df['Sector 3'] = value_list

submission_df = pd.merge(data,final_df,left_on='time_stamp_month',right_on='time_stamp',how='left')
submission_df.tail()

submission_df = submission_df[['serial_number','time_stamp_x','Sector 1','Sector 2','Sector 4','Sector 3']]
submission = submission_df.rename(columns={'time_stamp_x':'time_stamp'})

submission.to_csv('Random_Forest.csv',index=False)

for_submission = submission[['serial_number','Sector 3']]
for_submission.to_csv('Random_Forest_submit.csv',index=False)
