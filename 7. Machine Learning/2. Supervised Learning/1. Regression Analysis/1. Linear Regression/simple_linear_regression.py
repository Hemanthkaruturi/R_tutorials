# Simple Linear Regression

# Importing the libraries
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import os
from statsmodels.formula.api import ols

#setting up working directory
os.chdir('C:/Users/600037209/Documents/Classes/Data')

# Importing the dataset
dataset = pd.read_csv('Salary_Data.csv')
dataset
X = dataset.iloc[:, :-1].values
y = dataset.iloc[:, 1].values

# Splitting the dataset into the Training set and Test set
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 1/3, random_state = 0)
y_test
X_train


#manual method
train_data = pd.DataFrame()
train_data['X'] = X_train.reshape(1,-1)[0]
train_data['y'] = y_train
model = ols('y ~ X', train_data).fit()
model.summary()

#predict
def predict(test_dat):
    test_dat = test_dat.reshape(1,-1)[0]
    y_pred = []
    for x in test_dat:
        y = 9345.9424*x+0.00002682
        y_pred.append(y)
    return y_pred

y_pred = predict(X_test)

y_pred

test_data = pd.DataFrame()
test_data['Years of Experience'] = X_test.reshape(1,-1)[0]
test_data['Actual Salary'] = y_test
test_data['Predicted Salary'] = y_pred
test_data

#visualize data
plt.scatter(X_train, y_train, color='red')
plt.plot(X_test, y_pred,color='blue')
#############################################
# Feature Scaling
"""from sklearn.preprocessing import StandardScaler
sc_X = StandardScaler()
X_train = sc_X.fit_transform(X_train)
X_test = sc_X.transform(X_test)
sc_y = StandardScaler()
y_train = sc_y.fit_transform(y_train)"""

# Fitting Simple Linear Regression to the Training set
from sklearn.linear_model import LinearRegression
regressor = LinearRegression()
regressor.fit(X_train, y_train)

# Predicting the Test set results
y_pred = regressor.predict(X_test)

# Visualising the Training set results
plt.scatter(X_train, y_train, color = 'red')
plt.plot(X_train, regressor.predict(X_train), color = 'blue')
plt.title('Salary vs Experience (Training set)')
plt.xlabel('Years of Experience')
plt.ylabel('Salary')
plt.show()

# Visualising the Test set results
plt.scatter(X_test, y_test, color = 'red')
plt.plot(X_train, regressor.predict(X_train), color = 'blue')
plt.title('Salary vs Experience (Test set)')
plt.xlabel('Years of Experience')
plt.ylabel('Salary')
plt.show()
#Evaluate results

#Mean absolute error

#Manual
MAE_m = sum(np.abs(y_test - y_pred)) / len(y_test)
MAE_m

#package
from sklearn import metrics
print(metrics.mean_absolute_error(y_test,y_pred))

#Mean squared error
#manual
MSE_m = sum((y_test - y_pred)**2) / len(y_test)
MSE_m

#package
print(metrics.mean_squared_error(y_test,y_pred))


#Root mean squared error
RMSE = np.sqrt(sum((y_test - y_pred)**2) / len(y_test))
RMSE

print(np.sqrt(metrics.mean_squared_error(y_test,pred_test)))
