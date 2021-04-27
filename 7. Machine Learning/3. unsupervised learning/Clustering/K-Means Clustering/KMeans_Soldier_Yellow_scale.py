import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
#from sklearn.model_selection import KFold
#from sklearn.model_selection import cross_val_score
from sklearn.model_selection import train_test_split
from yellowbrick.classifier import ConfusionMatrix


filename = 'C:\Eminent\Soldier.csv'

# Read the file
regdata = pd.read_csv(filename)

regdata.columns
regdata.columns = ['Number', 'Attack', 'Defense', 'Water_Skils', 'Air_Skills', 'Speed','Endurance']

# Dimensions
print(regdata.shape)

regdata_array = regdata.values

soldier_features = regdata_array[:,[1,2,5,6]]

from sklearn.preprocessing import StandardScaler
?StandardScaler
scale_X = StandardScaler()
soldier_features_scale = scale_X.fit_transform(soldier_features)

  


from sklearn.cluster import KMeans
model = KMeans(n_clusters = 3)
  
model.fit(soldier_features_scale)
 
labels = model.predict(soldier_features_scale)
print(labels)

 
import matplotlib.pyplot as plot
 
Attack = regdata_array[ :,1]
Defense = regdata_array[ :,2]
 
plot.scatter(Attack, Defense, c=labels)

mymap = plot.get_cmap("rainbow")
plot.scatter(Attack, Defense, c=labels, cmap =  mymap)
plot.xlabel('Attack')
plot.ylabel('Defense')
plot.show()


print(labels)
type(labels)


centroids = model.cluster_centers_
centroid_Attack = centroids[:,0]
centroid_Defense = centroids[:,1]

plot.scatter(Attack, Defense, c=labels, cmap =  mymap)
plt.scatter(centroid_Attack, centroid_Defense, marker='D', s=100)


 
 
model.inertia_

ks = range(1, 30)
inertias = []
type(inertias)
for k in ks:
    print(k)
    # Create a KMeans instance with k clusters: model
    model = KMeans(n_clusters = k)
    model.fit(soldier_features_scale)
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
visualizer = KElbowVisualizer(model, k=(1,6))

visualizer.fit(soldier_features)    # Fit the data to the visualizer
visualizer.poof()    # Draw/show/poof the data

 