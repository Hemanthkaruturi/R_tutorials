import pandas as pd
from scipy import stats
import matplotlib.pyplot as plt
import os
os.chdir('C:/Users/600037209/Documents/Classes/Data')


podata = pd.read_csv('Complaint_Response_Time.csv')
list(podata)
podata.columns


ptime = podata['Response Time']

# Normality test

# Q-Q Plot
stats.probplot(ptime, plot = plt)

plt.savefig('Q_Q_Plot23.png')

# Normality test
stats.mstats.normaltest(ptime)
