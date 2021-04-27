import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
#from sklearn.model_selection import KFold
#from sklearn.model_selection import cross_val_score
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import confusion_matrix, cohen_kappa_score, classification_report,accuracy_score
from yellowbrick.classifier import ConfusionMatrix


filename = 'C:\Eminent\PimaIndian.csv'

# Read the file
regdata = pd.read_csv(filename)

regdata = regdata[[ 'preg', 'plas', 'pres', 'skin', 'test', 'mass', 'pedi', 'age', 'class']]
# Dimensions
print(regdata.shape)

array = regdata.values
#X = array[:, [5,7] ]
X = array[:, 0:8 ]
y = array[:,8]

 # Evaluate using a train and a test set
# Split

test_size = 0.33
seed = 123

X_train, X_test, y_train, y_test = train_test_split(X, y, 
                                                    test_size=test_size,
                                                    random_state=seed)


# Scale
from sklearn.preprocessing import StandardScaler
?StandardScaler
scale_X = StandardScaler()
X_train = scale_X.fit_transform(X_train)
X_test  = scale_X.transform(X_test)


from sklearn.decomposition import PCA
pca = PCA(n_components = None)
X_train = pca.fit_transform(X_train)
X_test = pca.transform(X_test)
pca.explained_variance_
exp_var = pca.explained_variance_ratio_
pca.components_
 
pca = PCA(n_components = 3)
X_train = pca.fit_transform(X_train)
X_test = pca.transform(X_test)
pca.explained_variance_
exp_var = pca.explained_variance_ratio_
pca.components_
 

from sklearn.linear_model import LogisticRegression
lg_reg = LogisticRegression()
model = lg_reg.fit(X_train, y_train)
y_pred = model.predict(X_test)
y_pred_train = model.predict(X_train)

cm_test = confusion_matrix(y_test, y_pred)
cm_train = confusion_matrix(y_train, y_pred_train)
print(cm_test)
print(cm_train)

cohen_kappa_score(y_test, y_pred)
classification_report(y_test, y_pred)
accuracy_score(y_test, y_pred)


# Yellow Brick

viz = ConfusionMatrix(LogisticRegression())
viz.fit(X_train, y_train)
viz.score(X_test, y_test)
viz.poof()



from yellowbrick.features.pca import PCADecomposition

# Specify the features of interest and the target
target = 'class'
features = [col for col in regdata.columns if col != 'class' ]
#features = [[ 'preg', 'plas', 'pres', 'skin', 'test', 'mass', 'pedi', 'age']

# Extract the instance data and the target
X = regdata[features]
y = regdata[target]

# Create a list of colors to assign to points in the plot
colors = np.array(['r' if yi else 'b' for yi in y])

visualizer = PCADecomposition(scale=True, color=colors)
visualizer.fit_transform(X, y)
visualizer.poof()

#3D
visualizer = PCADecomposition(scale=True, color=colors, proj_dim=3)
visualizer.fit_transform(X, y)
visualizer.poof()


#Biplot

# Specify the features of interest and the target
target = 'class'
features = [col for col in regdata.columns if col != 'class' ]

# Extract the instance data and the target
X = regdata[features]
y = regdata[target]

visualizer = PCADecomposition(scale=True, proj_features=True, color=colors)
visualizer.fit_transform(X, y)
visualizer.poof()

#3D Biplot
visualizer = PCADecomposition(scale=True, proj_features=True, proj_dim=3)
visualizer.fit_transform(X, y)
visualizer.poof()

