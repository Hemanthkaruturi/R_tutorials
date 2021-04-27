#!/usr/bin/env python
# coding: utf-8

# In[1]:


import os
os.getcwd()
os.chdir('C:/Users/600037209/OneDrive - Philips Lighting/Graphvizz')

# In[2]:


import pandas as pd
df = pd.read_excel("Workbook_09May2019.xlsx",sheet_name = 'Cleaned Data')


# In[3]:


df.shape;df.head();df.dtypes;df.shape


# In[4]:


df.columns


# In[5]:


df1 = df.drop(["Customer Code","Target",'Total Sales(Jan2016 to Mar2019)','Non Hue (Jan 2016 to Mar2019)','Hue Sales(Jan2016 to Mar2019)', 'Non Hue (Jan 2016 to Mar2019)',
       '% Hue Sales'],axis=1)
y=df.Target


# In[6]:


df1.columns


# In[7]:


from sklearn import preprocessing
le = preprocessing.LabelEncoder()


col = df1.select_dtypes(include=["object"]).columns
# print(col)
for c in col:
#     print(c)
    df1[c] = df1[c].fillna('')
    le.fit(df1[c])
    df1[c] = le.transform(df1[c])
print(df1.shape)

# list(le.inverse_transform([2, 2, 1]))


# In[ ]:


df1.head()


# In[8]:


from sklearn.tree import DecisionTreeClassifier
dtree=DecisionTreeClassifier(random_state=5)
dtree.fit(df1,y)


# In[11]:


from graphviz import Source
from sklearn import tree
Source(tree.export_graphviz(dtree, out_file=None, feature_names=df1.columns))


# In[ ]:


from IPython.display import SVG
graph = Source( tree.export_graphviz(dtree, out_file=None, feature_names=df1.columns))
SVG(graph.pipe(format='svg'))


# In[ ]:
