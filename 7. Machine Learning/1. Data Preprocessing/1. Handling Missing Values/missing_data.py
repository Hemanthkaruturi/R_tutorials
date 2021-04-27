# Data Preprocessing

# Importing the libraries
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import os

os.chdir('C:/Users/600037209/Documents/Classes/Data')

# Importing the dataset
dataset = pd.read_csv('Data.csv')
dataset.head()

dataset.isnull().sum()

dataset['Age'] = dataset['Age'].fillna(dataset['Age'].mean())


dataset['Age'].mean()



#### imputing missing values in Advertising data
adv = pd.read_csv('Advertising_Missing.csv')
adv.columns

#finding missing values in each column
adv.isnull().sum()
adv.columns

#impute using mean values
adv.mean()
adv_impute = adv.iloc[:,1:4].fillna(adv.iloc[:,1:4].mean())

#import mode
from statistics import mode
l = [1,2,2,3,1,1]
mode(l)

#impute missing values using imputer
from sklearn.preprocessing import Imputer
imputer = Imputer(missing_values = 'NaN', strategy = 'mean', axis = 0)
imputer = imputer.fit(adv.iloc[:, 1:4])
adv.iloc[:, 1:4] = imputer.transform(adv.iloc[:, 1:4])
