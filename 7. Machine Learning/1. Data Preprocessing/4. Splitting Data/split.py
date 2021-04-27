import pandas as pd
import os
os.chdir('C:/Users/600037209/Documents/Classes/Data')

# reading the Boston data
df = pd.read_csv("Boston_housing_train.csv")

#split data to test set and train set
from sklearn.model_selection import train_test_split
X = df.iloc[:,0:14]
y = df['medv']
X_train, X_test, y_train, y_test = train_test_split(X,y, test_size=0.2)

X_train.shape
X_test.shape
