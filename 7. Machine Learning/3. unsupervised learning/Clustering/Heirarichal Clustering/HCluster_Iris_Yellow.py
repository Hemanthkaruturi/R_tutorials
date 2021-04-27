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

import scipy.cluster.hierarchy as hclus
?hclus.dendrogram
?hclus.linkage

dgram = hclus.dendrogram(hclus.linkage(iris_features, method='ward'))  
plt.title('Dedrogram')
plt.xlabel('Flowers')
plt.ylabel('E.Disances')
plt.show()

from sklearn.cluster import AgglomerativeClustering

hc = AgglomerativeClustering(n_clusters = 3, affinity = 'euclidean', linkage='ward') 

labels = hc.fit_predict(iris_features)
print(labels) 

import matplotlib.pyplot as plot
 
sep_len = regdata_array[ :,0]
sep_wid = regdata_array[ :,1]
 
plot.scatter(sep_len, sep_wid, c=labels)

mymap = plot.get_cmap("rainbow")
plot.scatter(sep_len, sep_wid, c=labels, cmap =  mymap)

print(labels)
 
type(labels)
type(iris_class)
 
