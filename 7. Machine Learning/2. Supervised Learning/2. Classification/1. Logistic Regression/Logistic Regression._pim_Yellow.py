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


lg_reg = LogisticRegression()
model = lg_reg.fit(X,y)
y_pred = model.predict(X) 

cm = confusion_matrix(y, y_pred)
 
print(cm)

# Evaluate using a train and a test set
# Split

test_size = 0.33
seed = 123
X_train, X_test, y_train, y_test = train_test_split(X, y, 
                                                    test_size=test_size,
                                                    random_state=seed)
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



# Thresholds
from sklearn.linear_model import LogisticRegression
from yellowbrick.classifier import DiscriminationThreshold

# Instantiate the classification model and visualizer

logistic = LogisticRegression()
visualizer = DiscriminationThreshold(logistic)

visualizer.fit(X, y)  # Fit the training data to the visualizer
visualizer.poof()     # Draw/show/poof the data


from sklearn.linear_model import LogisticRegression
from yellowbrick.classifier import ROCAUC

# Instantiate the classification model and visualizer
logistic = LogisticRegression()
visualizer = ROCAUC(logistic)

visualizer.fit(X_train, y_train)  # Fit the training data to the visualizer
visualizer.score(X_test, y_test)  # Evaluate the model on the test data
g = visualizer.poof()             # Draw/show/poof the data



