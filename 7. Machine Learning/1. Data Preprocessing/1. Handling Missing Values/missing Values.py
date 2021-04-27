
import numpy as np
import pandas as pd
from sklearn.preprocessing import Imputer

filename = 'C:\Eminent\Advertising_Missing.csv'

# Read the file
data = pd.read_csv(filename)

 
X = data.iloc[:, 1:4].values
y = data.iloc[:, 4].values


from sklearn.preprocessing import Imputer
?Imputer
imputer = Imputer(missing_values = 'NaN',
                  strategy = 'mean',
                  axis = 0 )

type(imputer)
imputer = imputer.fit(X[ : , 0:3])

X[: , 0:3] = imputer.transform(X[:, 0:3])


# Encodnig 
import numpy as np
import pandas as pd
from sklearn.preprocessing import LabelEncoder

filename = 'C:\Eminent\Auto Data_label.csv'

# Read the file
data = pd.read_csv(filename)

X = data.iloc[:, 0:1].values
Y = data.iloc[:, 1].values

print(Y)

lab_encode_Y = LabelEncoder()
lab_encode_Y.fit_transform(Y)

print(Y)
Y = lab_encode_Y.fit_transform(Y)



filename = 'C:\Eminent\Salary_Data_Lab.csv'

# Read the file
data = pd.read_csv(filename)

X = data.iloc[:, 0:3].values
Y = data.iloc[:, 3].values

 
X[:, 1:3]
lab_encode_X = LabelEncoder()
lab_encode_X.fit_transform(X[:,1])
lab_encode_X.fit_transform(X[:,2])
 
X[:, 1] = lab_encode_X.fit_transform(X[:,1])
X[:, 2] = lab_encode_X.fit_transform(X[:,2])
print(X)

from sklearn.preprocessing import OneHotEncoder
ohe = OneHotEncoder(categorical_features = [1,2])
X = ohe.fit_transform(X).toarray()


# Split

from sklearn.cross_validation import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X,Y, test_size = .25, random_state=0)

