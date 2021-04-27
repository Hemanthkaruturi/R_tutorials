#import libraries
import pandas as pd
import numpy as np
import math as math
from scipy import stats
import matplotlib.pyplot as plt
#from pandas.tools.plotting import scatter_matrix
from statsmodels.formula.api import ols
from statsmodels.stats.anova import anova_lm
import os

#setting up working directory
os.chdir('C:/Users/600037209/Documents/Classes/Data')

regdata = pd.read_csv('Salary_Data_2.csv')
list(regdata)
regdata.columns
regdata.columns  = ['Salary', 'Age', 'Sex']
regdata.head()

# Bi-variate analysis
regdata.boxplot(column = 'Salary', by = 'Sex')
plt.scatter(regdata.Salary , regdata.Age)

#scatter_matrix(regdata)
#np.corrcoef(regdata)

regmodel = ols('Salary ~ Age', regdata).fit()

regmodel.summary()

#linear Regression formul  y = mx+c
x = regdata.Age.values
y = regdata.Salary.values
y_hat = 0.2728*x+0.4286
y_hat


new_x = 3.1
y_pred = 0.2728*new_x+0.4286
y_pred
#Visualizing data
plt.scatter(x,y)
fig = plt.plot(x,y_hat,lw=4, c='orange', label='Regression line')
plt.xlabel('Age')
plt.ylabel('Salary')
plt.show()
