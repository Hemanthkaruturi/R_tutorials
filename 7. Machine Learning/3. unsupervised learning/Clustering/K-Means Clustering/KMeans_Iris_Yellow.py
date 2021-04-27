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

from sklearn.cluster import KMeans
model = KMeans(n_clusters = 3)
  
model.fit(iris_features)
 
labels = model.predict(iris_features)
print(labels)

 
import matplotlib.pyplot as plot
 
sep_len = regdata_array[ :,0]
sep_wid = regdata_array[ :,1]
 
plot.scatter(sep_len, sep_wid, c=labels)

mymap = plot.get_cmap("rainbow")
plot.scatter(sep_len, sep_wid, c=labels, cmap =  mymap)

print(labels)
type(labels)


centroids = model.cluster_centers_
centroid_sep_len = centroids[:,0]
centroid_sep_wid = centroids[:,1]

plot.scatter(sep_len, sep_wid, c=labels, cmap =  mymap)
plt.scatter(centroid_sep_len, centroid_sep_wid, marker='D', s=100)


type(labels)
type(iris_class)

result_df = pd.DataFrame({'labels': labels , 'Actual': iris_class})

print(result_df)

cross_tab = pd.crosstab(result_df['labels'], result_df['Actual'])
print(cross_tab)

model.inertia_

ks = range(1, 20)
inertias = []
type(inertias)
for k in ks:
    print(k)
    # Create a KMeans instance with k clusters: model
    model = KMeans(n_clusters = k)
    model.fit(iris_features)
    inertias.append(model.inertia_)

plt.plot(ks, inertias, '-o')
plt.xlabel('number of clusters, k')
plt.ylabel('inertia')
plt.xticks(ks)
plt.show()




# Yellow Brick
from yellowbrick.cluster import KElbowVisualizer

# Instantiate the clustering model and visualizer
model = KMeans()
visualizer = KElbowVisualizer(model, k=(1,20))

visualizer.fit(iris_features)    # Fit the data to the visualizer
visualizer.poof()    # Draw/show/poof the data


from yellowbrick.cluster import InterclusterDistance

# Instantiate the clustering model and visualizer
visualizer = InterclusterDistance(KMeans(3))

visualizer.fit(iris_features) # Fit the training data to the visualizer
visualizer.poof() # Draw/show/poof the data
