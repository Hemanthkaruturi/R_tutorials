
import pandas as pd
import numpy as np
import math as math
from scipy import stats
import matplotlib.pyplot as plt
from pandas.tools.plotting import scatter_matrix
from statsmodels.formula.api import ols
from statsmodels.stats.anova import anova_lm

regdata = pd.read_csv('C:/Eminent/Mult_Reg_Yield.csv')
list(regdata)
regdata.shape 


scatter_matrix(regdata)
np.corrcoef(regdata)
pd.cor(regdata)

regmodel = ols('Yield ~ Temperature + Time', regdata).fit()

regmodel.summary()

anova_table = anova_lm(regmodel)
anova_table 

regmodel = ols('Yield ~  Time', regdata).fit()
regmodel.summary()

pred = regmodel.predict()
res  = regdata.Yield - pred 

# Residual Analysis
plt.scatter(regdata.Yield, pred)



stats.mstats.normaltest(res)

res_sq = res ** 2
mse    = res_sq.mean()
rmse   = math.sqrt(mse)
print(mse)
print(rmse)

stats.probplot(res, plot=plt)

plt.scatter(regdata.Time, res)

plt.scatter(pred, res)

