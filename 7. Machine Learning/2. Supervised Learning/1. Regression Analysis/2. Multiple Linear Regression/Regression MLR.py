#Import libraries
import pandas as pd
import numpy as np
import math as math
from scipy import stats
import matplotlib.pyplot as plt
#from pandas.tools.plotting import scatter_matrix
import statsmodels.api as sm
from statsmodels.stats.anova import anova_lm
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
import os

#setting working directory
os.chdir('C:/Users/600037209/Documents/Classes/Data')

regdata = pd.read_csv('Salary_Data_Lab.csv')
list(regdata)
regdata.shape

#chngdata = regdata.loc[ : , ['Sex ','Age','Education', 'Salary']]

# Evaluate using a train and a test set


array = regdata.values
X = array[:,[0,1,2] ]
y = array[:,3]


# Encoding
from sklearn.preprocessing import LabelEncoder

lab_encode_X = LabelEncoder()
#lab_encode_X.fit_transform(X[:,1])
#lab_encode_X.fit_transform(X[:,2])

X[:, 1] = lab_encode_X.fit_transform(X[:,1])
X[:, 2] = lab_encode_X.fit_transform(X[:,2])
print(X)

# Dummy variable
from sklearn.preprocessing import OneHotEncoder
ohe = OneHotEncoder(categorical_features = [1,2])
X = ohe.fit_transform(X).toarray()




# Split

test_size = 0.33
seed = 123
X_train, X_test, y_train, y_test = train_test_split(X, y,
                                                    test_size=test_size,
                                                    random_state=seed)
model = LinearRegression()
model.fit(X_train, y_train)

# Coefficients
model.coef_

# Predictions


pred_train = model.predict(X_train)

pred_test = model.predict(X_test)

# Performance
from sklearn.metrics import mean_squared_error, r2_score

# Mean Squared Error - MSE
df_test = pd.DataFrame({'Actual' : y_test, 'Predicted' : pred_test})
df_test['Residual'] = df_test.Actual - df_test.Predicted


np.mean((y_test- pred_test)**2)
mean_squared_error(y_test, pred_test)
r2_score(y_test, pred_test)
r2_score(y_train, pred_train)
from sklearn import metrics
print('Mean Absolute Error:', metrics.mean_absolute_error(y_test, pred_test))
print('Mean Squared Error:', metrics.mean_squared_error(y_test,   pred_test))
print('Root Mean Squared Error:', np.sqrt(metrics.mean_squared_error(y_test, pred_test)))


result_train = model.score(X_test, y_test)
print('Train score : ',  result_train)
result_test  = model.score(X_train, y_train)
print('Test score : ',  result_test)



from sklearn.model_selection import KFold
from sklearn.model_selection import cross_val_score
kfold = KFold(n_splits=10, random_state=7)
model = LinearRegression()
scoring = 'neg_mean_absolute_error'
results = cross_val_score(model, X, y, cv=kfold, scoring=scoring)
print("MAE: %.3f (%.3f)" % (results.mean(), results.std()))

scoring = 'neg_mean_squared_error'
results = cross_val_score(model, X, y, cv=kfold, scoring=scoring)
print("MSE: %.3f (%.3f)" % (results.mean(), results.std()))

scoring = 'r2'
results = cross_val_score(model, X, y, cv=kfold, scoring=scoring)
print("R^2: %.3f (%.3f)" % (results.mean(), results.std()))

#The Mean Absolute Error (or MAE) is the sum of the absolute di
#erences between predictions
#and actual values. It gives an idea of how wrong the predictions were. The measure gives an
#idea of the magnitude of the error, but no idea of the direction (e.g. over or under predicting).
