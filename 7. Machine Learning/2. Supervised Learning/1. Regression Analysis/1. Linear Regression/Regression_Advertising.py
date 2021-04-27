#Importing libraries
import pandas as pd
import numpy as np
import math as math
from scipy import stats
import matplotlib.pyplot as plt
#from pandas.tools.plotting import scatter_matrix
from statsmodels.formula.api import ols
from statsmodels.stats.anova import anova_lm
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn import metrics
import os

#setting up working directory
os.chdir('C:/Users/600037209/Documents/Classes/Data')

regdata = pd.read_csv('Advertising.csv')
list(regdata)
regdata.shape

np.corrcoef(regdata.TV,regdata.sales)[0,1]
plt.scatter(regdata.TV,regdata.sales)
# Evaluate using a train and a test set


array = regdata.values
X = array[:,0:1]
y = array[:,3]

test_size = 0.25
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

# Performance testing
from sklearn.metrics import mean_squared_error, r2_score

# Mean Squared Error - MSE
df_test = pd.DataFrame({'Actual' : y_test, 'Predicted' : pred_test})
df_test['Residual'] = df_test.Actual - df_test.Predicted


np.mean((y_test- pred_test)**2)
metrics.mean_squared_error(y_test, pred_test)

from sklearn import metrics
print('Mean Absolute Error:', metrics.mean_absolute_error(y_test, pred_test))
print('Root Mean Squared Error:', np.sqrt(metrics.mean_squared_error(y_test, pred_test)))
print('Mean Squared Error:', metrics.mean_squared_error(y_test,   pred_test))


result_test = model.score(X_test, y_test)
print('Test score : ',  result_test)
result_train  = model.score(X_train, y_train)
print('Train score : ',  result_train)


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
