import pandas as pd
import numpy as np
from sklearn.model_selection import StratifiedKFold
from sklearn.model_selection import cross_val_score
import sklearn.neighbors as nb
from sklearn import preprocessing
import matplotlib.pyplot as plt
from sklearn.feature_selection import mutual_info_classif
from sklearn.feature_selection import SelectKBest
from sklearn.model_selection import GridSearchCV
from sklearn.decomposition import PCA
from sklearn.discriminant_analysis import LinearDiscriminantAnalysis


def preprocess_knn(path):
    n = 30
    df = pd.read_csv("../dataset_clean/" + path)
    X = df.drop(["Passed"], axis=1).values
    y = df["Passed"].values.astype(int)
    # STANDARDIZE DATA
    cv = StratifiedKFold(n_splits=10, random_state=1)
    '''
    for i in range(n):
        print('std:', X[:, i].std(), 'min', X[:, i].min(), 'max', X[:, i].max())
    '''
    cv_scores = cross_val_score(nb.KNeighborsClassifier(), X=X, y=y, cv=cv, scoring='accuracy')
    print(np.mean(cv_scores))
    # BAJO SCORE DEL CROSS VALIDATION
    scaler = preprocessing.StandardScaler().fit(X)
    X2 = scaler.transform(X)
    '''
    for i in range(n):
        print('std:', X2[:, i].std(), 'min', X2[:, i].min(), 'max', X2[:, i].max())
    '''
    cv_scores = cross_val_score(nb.KNeighborsClassifier(), X=X2, y=y, cv=cv, scoring='accuracy')
    print(np.mean(cv_scores))

    # IRRELEVANT COLUMNS
    columns = [str(i + 1) for i in range(n)]
    df = pd.DataFrame(data=X2, columns=columns)
    df["Passed"] = y
    print(df.head())

    plt.subplots(figsize=(10, 10))
    plt.subplots_adjust(hspace=0.27, wspace=0.5)
    for i in range(n):
        plt.subplot(6, 5, 0 + i + 1)
        df[df['Passed'] == 0][str(i + 1)].plot.hist(bins=10)
        df[df['Passed'] == 1][str(i + 1)].plot.hist(bins=10)
    plt.savefig("histogram_of_values.png")
    plt.close()

    cv_scores = cross_val_score(nb.KNeighborsClassifier(), X=X2, y=y, cv=cv, scoring='accuracy')
    print(np.mean(cv_scores))
    cv_scores = cross_val_score(nb.KNeighborsClassifier(), X=X2[:, [2, 14, 20, 29]], y=y, cv=cv, scoring='accuracy')
    print(np.mean(cv_scores))

    X_new = SelectKBest(mutual_info_classif, k=2).fit_transform(X, y)
    cv_scores = cross_val_score(nb.KNeighborsClassifier(), X=X_new, y=y, cv=cv, scoring='accuracy')
    print(np.mean(cv_scores))

    original = np.zeros(n)
    for i in range(n):
        X_new = SelectKBest(mutual_info_classif, k=i + 1).fit_transform(X2, y)
        cv_scores = cross_val_score(nb.KNeighborsClassifier(), X=X_new, y=y, cv=cv, scoring='accuracy')
        original[i] = np.mean(cv_scores)

    plt.xticks(np.arange(0, n, step=1))
    plt.plot(range(1, n+1), original)
    plt.savefig("xticks.png")
    plt.close()

    X_new = SelectKBest(mutual_info_classif, k=2).fit_transform(X, y)

    lr = []
    for ki in range(1, 30, 2):
        cv_scores = cross_val_score(nb.KNeighborsClassifier(n_neighbors=ki), X=X_new, y=y, cv=10)
        lr.append(np.mean(cv_scores))
    plt.plot(range(1, 30, 2), lr, 'b', label='No weighting')

    lr = []
    for ki in range(1, 30, 2):
        cv_scores = cross_val_score(nb.KNeighborsClassifier(n_neighbors=ki, weights='distance'), X=X_new, y=y, cv=10)
        lr.append(np.mean(cv_scores))
    plt.plot(range(1, 30, 2), lr, 'r', label='Weighting')
    plt.xlabel('k')
    plt.ylabel('Accuracy')
    plt.legend(loc='upper right')
    plt.grid()
    plt.tight_layout()

    plt.savefig("kbest.png")

    params = {'n_neighbors': list(range(1, 30, 2)), 'weights': ('distance', 'uniform')}
    knc = nb.KNeighborsClassifier()
    clf = GridSearchCV(knc, param_grid=params, cv=cv, n_jobs=-1)  # If cv is integer, by default is Stratifyed
    clf.fit(X_new, y)
    print("Best Params=", clf.best_params_, "Accuracy=", clf.best_score_)

    pca = PCA(n_components=2)
    pca.fit(X2)
    X_pca = pca.transform(X2)

    params = {'n_neighbors': list(range(1, 30, 2)), 'weights': ('distance', 'uniform')}
    knc = nb.KNeighborsClassifier()
    clf = GridSearchCV(knc, param_grid=params, cv=cv, n_jobs=-1)  # If cv is integer, by default is Stratifyed
    clf.fit(X_pca, y)
    print("Best Params=", clf.best_params_, "Accuracy=", clf.best_score_)

    lda = LinearDiscriminantAnalysis(n_components=2)
    X_lda = lda.fit(X2, y).transform(X2)

    params = {'n_neighbors': list(range(1, 30, 2)), 'weights': ('distance', 'uniform')}
    knc = nb.KNeighborsClassifier()
    clf = GridSearchCV(knc, param_grid=params, cv=cv, n_jobs=-1)  # If cv is integer, by default is Stratifyed
    clf.fit(X_lda, y)
    print("Best Params=", clf.best_params_, "Accuracy=", clf.best_score_)


if __name__ == '__main__':
    a = input("What dataset do you want to preprocess?\n 1-por\n 2-mat\n")
    if a == "1":
        path = "clean_student_por.csv"
    elif a == "2":
        path = "clean_student_mat.csv"
    else:
        raise Exception("Incorrect input")

    preprocess_knn(path)
