import pandas as pd
import numpy  as np
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split
#from sklearn.model_selection import KFold
#from sklearn.model_selection import cross_val_score
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import confusion_matrix, cohen_kappa_score, classification_report,accuracy_score

filename = 'C:\Eminent\PimaIndian.csv'

# Read the file
regdata = pd.read_csv(filename)

regdata = regdata[[ 'preg', 'plas', 'pres', 'skin', 'test', 'mass', 'pedi', 'age', 'class']]
# Dimensions
print(regdata.shape)

array = regdata.values
X = array[:, [5,7] ]
y = array[:,8]


lg_reg = LogisticRegression()
  
# Evaluate using a train and a test set
# Split
seed = 123

test_size = 0.05

X_train, X_test, y_train, y_test = train_test_split(X, y, 
                                                    test_size=test_size,
                                                    random_state=seed)
model_05 = lg_reg.fit(X_train, y_train)

test_size = 0.1
X_train, X_test, y_train, y_test = train_test_split(X, y, 
                                                    test_size=test_size,
                                                    random_state=seed)
model_10 = lg_reg.fit(X_train, y_train)

test_size = 0.2
X_train, X_test, y_train, y_test = train_test_split(X, y, 
                                                    test_size=test_size,
                                                    random_state=seed)
model_20 = lg_reg.fit(X_train, y_train)

test_size = 0.40
X_train, X_test, y_train, y_test = train_test_split(X, y, 
                                                    test_size=test_size,
                                                    random_state=seed)
model_40 = lg_reg.fit(X_train, y_train)
 

 
h = 0.02
c = 1.0

# fit model
 
# create a mesh to plot in
x_min, x_max = X[:, 0].min()-1, X[:, 0].max()+1
y_min, y_max = X[:, 1].min()-1, X[:, 1].max()+1
xx, yy = np.meshgrid(np.arange(x_min, x_max, h),
                     np.arange(y_min, y_max, h))

titles = ['model_05',
          'model_10',
          'model_20',
          'model_40']

plt.figure(3)
for i, clf in enumerate((model_05,model_10,model_20,model_40)):
    plt.subplot(2, 2, i+1)
    plt.subplots_adjust(wspace=0.4, hspace=0.4)

    Z = clf.predict(np.c_[xx.ravel(), yy.ravel()])
    Z = Z.reshape(xx.shape)

    plt.contourf(xx, yy, Z, cmap=plt.cm.Paired, alpha=0.8)

    plt.scatter(X[:, 0], X[:, 1], c=y*100, cmap=plt.cm.Paired)
    plt.xlabel('age')
    plt.ylabel('mass')
    plt.xlim(xx.min(), xx.max())
    plt.ylim(yy.min(), yy.max())

    plt.xticks(())
    plt.yticks(())
    plt.title(titles[i])


