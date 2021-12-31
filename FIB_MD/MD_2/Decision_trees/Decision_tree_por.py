import sklearn
import numpy as np                     # Llibreria matemÃ tica
import pandas as pd
import sklearn.model_selection as cv    # Pel Cross-validation
from sklearn.naive_bayes import GaussianNB  # For numerical featuresm assuming normal distribution
from sklearn.metrics import confusion_matrix
# interval confidence
from statsmodels.stats.proportion import proportion_confint
from sklearn import tree
from sklearn.externals.six import StringIO
import pydot
from IPython.display import Image
from sklearn.model_selection import GridSearchCV
import os


path = os.path.dirname(os.path.abspath(__file__))
digits = pd.read_csv(path + "/clean_student_por.csv")



# Separate data from labels
#digits = digits.drop(['failures'], axis=1)
X = digits.drop(['Passed'], axis=1).values
y = digits['Passed'].values
(X_train, X_test,  y_train, y_test) = cv.train_test_split(X, y, test_size=.3, random_state=1)




# Train Naive Bayes to compare results
print("Train Naive Bayes")
print()
clf = GaussianNB()
pred = clf.fit(X_train, y_train).predict(X_test)
print(confusion_matrix(y_test, pred))
print()
print("Accuracy:", sklearn.metrics.accuracy_score(y_test, pred))
print()
print("f1-score:", sklearn.metrics.f1_score(y_test, pred))
print()
print(sklearn.metrics.classification_report(y_test, pred))
#epsilon = sklearn.metrics.accuracy_score(y_test, pred)
epsilon = sklearn.metrics.f1_score(y_test, pred);
proportion_confint(count=epsilon*X_test.shape[0], nobs=X_test.shape[0], alpha=0.05, method='binom_test')
print("Interval of confidence:", proportion_confint(count=epsilon*X_test.shape[0], nobs=X_test.shape[0], alpha=0.05, method='binom_test'))




# Train and Print A Decision Tree
print("1 DT")
print()
clf = tree.DecisionTreeClassifier()
clf = clf.fit(X_train, y_train)
pred = clf.predict(X_test)

# Obtain accuracy score of learned classifier on test data
print("Obtain accuracy score of our 1 DT on test data")
print()
print(clf.score(X_test, y_test))
print(confusion_matrix(y_test, pred))
print()
print("f1-score:", sklearn.metrics.f1_score(y_test, pred))
print()
print(sklearn.metrics.classification_report(y_test, pred))
epsilon = sklearn.metrics.f1_score(y_test, pred);
proportion_confint(count=epsilon*X_test.shape[0], nobs=X_test.shape[0], alpha=0.05, method='binom_test')
print("Interval of confidence:", proportion_confint(count=epsilon*X_test.shape[0], nobs=X_test.shape[0], alpha=0.05, method='binom_test'))

dot_data = StringIO()
tree.export_graphviz(clf, out_file=dot_data, filled=True, rounded=True, special_characters=True)
graph = pydot.graph_from_dot_data(dot_data.getvalue())
graph[0].write_png('DT1.png')
Image(graph[0].create_png())

print("2 DT")
print()
clf=tree.DecisionTreeClassifier(criterion='entropy', min_samples_split=20, min_impurity_split=0.2)
clf = clf.fit(X_train, y_train)
pred = clf.predict(X_test)


# Obtain accuracy score of learned classifier on test data
print()
print(" Obtain accuracy score of 2 DT on test data")
print()
print(clf.score(X_test, y_test))
print(confusion_matrix(y_test, pred))
print()
print(sklearn.metrics.classification_report(y_test, pred))
epsilon = sklearn.metrics.f1_score(y_test, pred)
proportion_confint(count=epsilon*X_test.shape[0], nobs=X_test.shape[0], alpha=0.05, method='binom_test')
print("f1-score:", sklearn.metrics.f1_score(y_test, pred))
print()
print("Interval of confidence:", proportion_confint(count=epsilon*X_test.shape[0], nobs=X_test.shape[0], alpha=0.05, method='binom_test'))

dot_data = StringIO()
tree.export_graphviz(clf, out_file=dot_data, filled=True, rounded=True, special_characters=True)
graph = pydot.graph_from_dot_data(dot_data.getvalue())
graph[0].write_png('DT2.png')
Image(graph[0].create_png())

print("3 DT")
print()
clf=tree.DecisionTreeClassifier(criterion='entropy', min_samples_split=20, min_impurity_split=0.4)
clf = clf.fit(X_train, y_train)
pred = clf.predict(X_test)


# Obtain accuracy score of learned classifier on test data
print()
print(" Obtain accuracy score of 3 DT on test data")
print()
print(clf.score(X_test, y_test))
print(confusion_matrix(y_test, pred))
print()
print(sklearn.metrics.classification_report(y_test, pred))
epsilon = sklearn.metrics.f1_score(y_test, pred)
proportion_confint(count=epsilon*X_test.shape[0], nobs=X_test.shape[0], alpha=0.05, method='binom_test')
print("f1-score:", sklearn.metrics.f1_score(y_test, pred))
print()
print("Interval of confidence:", proportion_confint(count=epsilon*X_test.shape[0], nobs=X_test.shape[0], alpha=0.05, method='binom_test'))

dot_data = StringIO()
tree.export_graphviz(clf, out_file=dot_data, filled=True, rounded=True, special_characters=True)
graph = pydot.graph_from_dot_data(dot_data.getvalue())
graph[0].write_png('DT3.png')
Image(graph[0].create_png())

print("4 DT")
print()
clf=tree.DecisionTreeClassifier(criterion='entropy', min_samples_split=40, min_impurity_split=0.2)
clf = clf.fit(X_train, y_train)
pred = clf.predict(X_test)


# Obtain accuracy score of learned classifier on test data
print()
print(" Obtain accuracy score of 4 DT on test data")
print()
print(clf.score(X_test, y_test))
print(confusion_matrix(y_test, pred))
print()
print(sklearn.metrics.classification_report(y_test, pred))
epsilon = sklearn.metrics.f1_score(y_test, pred)
proportion_confint(count=epsilon*X_test.shape[0], nobs=X_test.shape[0], alpha=0.05, method='binom_test')
print("f1-score:", sklearn.metrics.f1_score(y_test, pred))
print()
print("Interval of confidence:", proportion_confint(count=epsilon*X_test.shape[0], nobs=X_test.shape[0], alpha=0.05, method='binom_test'))

dot_data = StringIO()
tree.export_graphviz(clf, out_file=dot_data, filled=True, rounded=True, special_characters=True)
graph = pydot.graph_from_dot_data(dot_data.getvalue())
graph[0].write_png('DT4.png')
Image(graph[0].create_png())


print("5 DT")
print()
clf=tree.DecisionTreeClassifier(criterion='entropy', min_samples_split=40, min_impurity_split=0.4)
clf = clf.fit(X_train, y_train)
pred = clf.predict(X_test)


# Obtain accuracy score of learned classifier on test data
print()
print(" Obtain accuracy score of 5 DT on test data")
print()
print(clf.score(X_test, y_test))
print(confusion_matrix(y_test, pred))
print()
print(sklearn.metrics.classification_report(y_test, pred))
epsilon = sklearn.metrics.f1_score(y_test, pred)
proportion_confint(count=epsilon*X_test.shape[0], nobs=X_test.shape[0], alpha=0.05, method='binom_test')
print("f1-score:", sklearn.metrics.f1_score(y_test, pred))
print()
print("Interval of confidence:", proportion_confint(count=epsilon*X_test.shape[0], nobs=X_test.shape[0], alpha=0.05, method='binom_test'))

dot_data = StringIO()
tree.export_graphviz(clf, out_file=dot_data, filled=True, rounded=True, special_characters=True)
graph = pydot.graph_from_dot_data(dot_data.getvalue())
graph[0].write_png('DT5.png')
Image(graph[0].create_png())


print(" GS-DT ")
print()
params = {'min_impurity_split': list(np.linspace(0, 1, 21)), 'min_samples_split': list(range(2, 102, 11))}
clf = GridSearchCV(tree.DecisionTreeClassifier(criterion='entropy'), param_grid=params, cv=10, n_jobs=-1, scoring='f1')  # If cv is integer, by default is Stratifyed
#clf = GridSearchCV(tree.DecisionTreeClassifier(criterion='entropy'), param_grid=params, cv=10, n_jobs=-1)  # If cv is integer, by default is Stratifyed

clf.fit(X_train, y_train)

print("Best Params=", clf.best_params_, "Accuracy=", clf.best_score_)
print()
clf = tree.DecisionTreeClassifier(criterion='entropy', min_samples_split=clf.best_params_['min_samples_split'], min_impurity_split=clf.best_params_['min_impurity_split'])

clf = clf.fit(X_train, y_train)
pred = clf.predict(X_test)


# Obtain accuracy score of learned classifier on test data
#print(clf.score(X_test, y_test))
print(confusion_matrix(y_test, pred))
print()
print("f1-score:", sklearn.metrics.f1_score(y_test, pred))
print("f1-score negative:", sklearn.metrics.f1_score(y_test, pred, pos_label=0))
print()
print(sklearn.metrics.classification_report(y_test, pred))
epsilon = sklearn.metrics.accuracy_score(y_test, pred)
proportion_confint(count=epsilon*X_test.shape[0], nobs=X_test.shape[0], alpha=0.05, method='binom_test')
print("Interval of confidence:", proportion_confint(count=epsilon*X_test.shape[0], nobs=X_test.shape[0], alpha=0.05, method='binom_test'))

dot_data = StringIO()
tree.export_graphviz(clf, out_file=dot_data, filled=True, rounded=True, special_characters=True)
graph = pydot.graph_from_dot_data(dot_data.getvalue())
graph[0].write_png('DT_GS.png')
#graph[0].write_png('DT_GS_RM14.png')
Image(graph[0].create_png())



