
import pandas as pd
import numpy as np
import math as math
from scipy import stats
import matplotlib.pyplot as plt
from pandas.tools.plotting import scatter_matrix
import statsmodels.formula.api as sm

from statsmodels.stats.anova import anova_lm
from sklearn.linear_model import LogisticRegression


lgrdata = pd.read_csv('C:/Eminent/Logistic_Reg.csv')
lgrdata.columns

class_count = lgrdata.groupby('Outcome').size()
class_count
x = lgrdata[ ['Ind_Exp_Act_Score', 'Tran_Speed_Score', 'Peer_Comb_Score']]
y = lgrdata.Outcome

x["Intercept"] = 1

lgrmodel = sm.Logit(y,x)
result = lgrmodel.fit()
result.summary()


pred = result.predict(x)
output = pd.DataFrame(pred)
output.to_csv('C:\Eminent\Python\Logistic_out.csv')
