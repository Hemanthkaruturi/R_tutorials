#Import libraries
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from statsmodels import stats
from statsmodels.formula.api import ols
from statsmodels.stats.anova import anova_lm
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
import os

#setting up working directory
os.chdir('C:/Users/600037209/Documents/Classes/Data')

#Import data
airlines = pd.read_csv('Passenger.csv')
airlines.columns
airlines.head()

#finding relation between 2 variables
np.corrcoef(airlines.Passengers, airlines.Cost)[0,1]
np.corrcoef(airlines.Cost, airlines.Passengers)[0,1]

#Split data into train and test sets
test_size = 0.25
seed = 123
X = airlines.iloc[:, :-1].values
y = airlines.iloc[:, 1].values
X_train, X_test, y_train, y_test = train_test_split(X, y,
                                                    test_size=test_size,
                                                    random_state=seed)

#Applying linear model
model = LinearRegression()
model.fit(X_train, y_train)

# Coefficients
model.coef_


# Predictions
pred_train = model.predict(X_train)

pred_test = model.predict(X_test)

# Visualising the Training set results
plt.scatter(X_train, y_train, color = 'red')
plt.plot(X_train, model.predict(X_train), color = 'blue')
plt.title('Cost vs Passengers (Training set)')
plt.xlabel('Passengers')
plt.ylabel('Cost')
plt.show()

# Visualising the Test set results
plt.scatter(X_test, y_test, color = 'red')
plt.plot(X_train, model.predict(X_train), color = 'blue')
plt.title('Salary vs Experience (Test set)')
plt.xlabel('Years of Experience')
plt.ylabel('Salary')
plt.show()

#Evaluate results

#Mean absolute error
#Manual
MAE_m = sum(np.abs(y_test - pred_test)) / len(y_test)
MAE_m

#package
from sklearn import metrics
print(metrics.mean_absolute_error(y_test,pred_test))

#Mean squared error
#manual
MSE_m = sum((y_test - pred_test)**2) / len(y_test)
MSE_m

#package
print(metrics.mean_squared_error(y_test,pred_test))


#Root mean squared error
RMSE = np.sqrt(sum((y_test - pred_test)**2) / len(y_test))
RMSE

print(np.sqrt(metrics.mean_squared_error(y_test,pred_test)))

#model score
result_test = model.score(X_test, y_test)
print('Test score : ',  result_test)
result_train  = model.score(X_train, y_train)
print('Train score : ',  result_train)
