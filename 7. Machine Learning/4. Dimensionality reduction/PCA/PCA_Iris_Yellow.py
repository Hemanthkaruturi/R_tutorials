import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
#from sklearn.model_selection import KFold
#from sklearn.model_selection import cross_val_score
from sklearn.model_selection import train_test_split
from yellowbrick.classifier import ConfusionMatrix


filename = 'C:\Eminent\Iris.csv'

# Read the file
regdata = pd.read_csv(filename)

regdata.columns
regdata.columns = ['sepal_length', 'sepal_width', 'petal_length', 'petal_width', 'Class']
# Dimensions
print(regdata.shape)

regdata_array = regdata.values

iris_class = regdata_array[:,4]
iris_features = regdata_array[:,[0,1,2,3]]

from sklearn.decomposition import PCA
pca = PCA(n_components = None)
iris_pca = pca.fit_transform(iris_features)
exp_var = pca.explained_variance_

4.24439864+ 0.24132665+ 0.07800343+ 0.02352515

4.24439864/4.5872538700000005
pca.explained_variance_ratio_
pca.components_

pca = PCA(n_components = 2)
iris_pca = pca.fit_transform(iris_features)
pca.explained_variance_
pca.explained_variance_ratio_
pca.components_

#pca.transform(iris_test)

?PCA



