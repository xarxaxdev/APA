import sklearn
import numpy as np                     # Llibreria matemÃ tica
import pandas as pd
import sklearn.model_selection as cv    # Pel Cross-validation
from sklearn.naive_bayes import GaussianNB  # For numerical featuresm assuming normal distribution
from sklearn.naive_bayes import MultinomialNB  # For features with counting numbers (f.i. hown many times word appears in doc)
from sklearn.naive_bayes import BernoulliNB  # For binari features (f.i. word appears or not in document)
from sklearn.metrics import confusion_matrix
# interval confidence
from statsmodels.stats.proportion import proportion_confint
from sklearn import tree
from sklearn.externals.six import StringIO
import pydot
from IPython.display import Image
from sklearn.model_selection import GridSearchCV


digits = pd.read_csv("/home/david/Escritorio/MD/DecisionTrees/Project2/k-nn/clean_knn_student_por.csv")

# Separate data from labels
X = digits.drop(['Grade'], axis=1).values
y = digits['Grade'].values

(X_train, X_test,  y_train, y_test) = cv.train_test_split(X, y, test_size=.3, random_state=1)

# Train Naive Bayes to compare results
clf = GaussianNB()
pred = clf.fit(X_train, y_train).predict(X_test)
print(confusion_matrix(y_test, pred))
print()
print("Accuracy:", sklearn.metrics.accuracy_score(y_test, pred))
print()
print(sklearn.metrics.classification_report(y_test, pred))
epsilon = sklearn.metrics.accuracy_score(y_test, pred)
proportion_confint(count=epsilon*X_test.shape[0], nobs=X_test.shape[0], alpha=0.05, method='binom_test')

# Train and Print A Decision Tree

clf = tree.DecisionTreeClassifier()
clf = clf.fit(X_train, y_train)
pred = clf.predict(X_test)

# Obtain accuracy score of learned classifier on test data
print(clf.score(X_test, y_test))
print(confusion_matrix(y_test, pred))
print()
print("Accuracy:", sklearn.metrics.accuracy_score(y_test, pred))
print()
print(sklearn.metrics.classification_report(y_test, pred))
epsilon = sklearn.metrics.accuracy_score(y_test, pred)
proportion_confint(count=epsilon*X_test.shape[0], nobs=X_test.shape[0], alpha=0.05, method='binom_test')

clf=tree.DecisionTreeClassifier(criterion='entropy', min_samples_split=2,min_impurity_split=0.2)
clf = clf.fit(X_train, y_train)
pred = clf.predict(X_test)

# Obtain accuracy score of learned classifier on test data
print(clf.score(X_test, y_test))
print(confusion_matrix(y_test, pred))
print()
print("Accuracy:", sklearn.metrics.accuracy_score(y_test, pred))
print()
print(sklearn.metrics.classification_report(y_test, pred))
#epsilon = sklearn.metrics.accuracy_score(y_test, pred)
epsilon = sklearn.metrics.f1_score(y_test, pred);
print("Interval of confudence:", proportion_confint(count=epsilon*X_test.shape[0], nobs=X_test.shape[0], alpha=0.05, method='binom_test'))

dot_data = StringIO()
tree.export_graphviz(clf, out_file=dot_data, filled=True, rounded=True, special_characters=True)
graph = pydot.graph_from_dot_data(dot_data.getvalue())
graph[0].write_png('DT1_por.png')
Image(graph[0].create_png())



params = {'min_impurity_split': list(np.linspace(0, 1, 21)), 'min_samples_split': list(range(2, 102, 11))}
clf = GridSearchCV(tree.DecisionTreeClassifier(criterion='entropy'), param_grid=params, cv=10, n_jobs=-1)  # If cv is integer, by default is Stratifyed
clf.fit(X_train, y_train)
print("Best Params=", clf.best_params_, "Accuracy=", clf.best_score_)

clf = tree.DecisionTreeClassifier(criterion='entropy', min_samples_split=60, min_impurity_split=0.35)
clf = clf.fit(X_train, y_train)
pred = clf.predict(X_test)

# Obtain accuracy score of learned classifier on test data
print(clf.score(X_test, y_test))
print(confusion_matrix(y_test, pred))
print()
print("Accuracy:", sklearn.metrics.accuracy_score(y_test, pred))
print()
print(sklearn.metrics.classification_report(y_test, pred))
#epsilon = sklearn.metrics.accuracy_score(y_test, pred)
epsilon = sklearn.metrics.f1_score(y_test, pred);
proportion_confint(count=epsilon*X_test.shape[0], nobs=X_test.shape[0], alpha=0.05, method='binom_test')

dot_data = StringIO()
tree.export_graphviz(clf, out_file=dot_data, filled=True, rounded=True, special_characters=True)
graph = pydot.graph_from_dot_data(dot_data.getvalue())
graph[0].write_png('DT2_por.png')
Image(graph[0].create_png())


