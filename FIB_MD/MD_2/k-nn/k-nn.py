import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import sklearn
from sklearn.feature_selection import SelectKBest, mutual_info_classif
from sklearn.metrics import confusion_matrix
from sklearn import metrics
import sklearn.model_selection as cv
import sklearn.neighbors as nb
from sklearn.model_selection import cross_val_score
from sklearn.model_selection import cross_val_predict
from sklearn.metrics import accuracy_score
from sklearn.model_selection import learning_curve
from sklearn.model_selection import GridSearchCV
from statsmodels.stats.proportion import proportion_confint
from sklearn.naive_bayes import GaussianNB  # For numerical featuresm assuming normal distribution
from sklearn.naive_bayes import MultinomialNB  # For features with counting numbers (f.i. hown many times word appears in doc)
from sklearn.naive_bayes import BernoulliNB  # For binari features (f.i. word appears or not in document)

def knn(path):
    df = pd.read_csv("../dataset_clean/" + path)
    X = df.drop(["Passed"], axis=1).values
    y = df["Passed"].values.astype(int)
    # Let's do a simple cross-validation: split data into training and test sets (test 30% of data)
    (X_train, X_test, y_train, y_test) = cv.train_test_split(X, y, test_size=.3, random_state=1)

    # Create a kNN classifier object
    knc = nb.KNeighborsClassifier()

    # Train the classifier
    knc.fit(X_train, y_train)

    # Obtain accuracy score of learned classifier on test data
    print(knc.score(X_test, y_test))

    # More information with confussion matrix
    y_pred = knc.predict(X_test)
    print(sklearn.metrics.confusion_matrix(y_test, y_pred))

    # Obtain Recall, Precision and F-Measure for each class
    print(metrics.classification_report(y_test, y_pred))

    cv_scores = cross_val_score(nb.KNeighborsClassifier(),
                                X=X,
                                y=y,
                                cv=10, scoring='accuracy')

    # cv_scores is a list with 10 accuracies (one for each validation)
    print(cv_scores)

    # Let's get the mean of the 10 validations (and standard deviation of them)
    print(np.mean(cv_scores))
    print(np.std(cv_scores))

    # Method 2
    # Build confussion matrix of all 10 cross-validations
    predicted = cross_val_predict(nb.KNeighborsClassifier(), X=X, y=y, cv=10)

    print(sklearn.metrics.confusion_matrix(y, predicted))
    print(sklearn.metrics.accuracy_score(y, predicted))
    confmat = sklearn.metrics.confusion_matrix(y, predicted)

    fig, ax = plt.subplots(figsize=(2.5, 2.5))
    ax.matshow(confmat, cmap=plt.cm.Blues, alpha=0.3)
    for i in range(confmat.shape[0]):
        for j in range(confmat.shape[1]):
            ax.text(x=j, y=i, s=confmat[i, j], va='center', ha='center', fontsize=7)

    plt.xlabel('Predicted label')
    plt.ylabel('True label')

    plt.tight_layout()
    plt.savefig('ConMatrix.png', dpi=600)
    plt.close()
    print(metrics.classification_report(y_test, y_pred))

    # Let's see how amount of training data influences accuracy

    train_sizes, train_scores, test_scores = \
        learning_curve(estimator=nb.KNeighborsClassifier(n_neighbors=3),
                       X=X,
                       y=y,
                       train_sizes=np.linspace(0.05, 1.0, 10),
                       cv=10,
                       n_jobs=-1)

    train_mean = np.mean(train_scores, axis=1)
    train_std = np.std(train_scores, axis=1)
    test_mean = np.mean(test_scores, axis=1)
    test_std = np.std(test_scores, axis=1)

    plt.plot(train_sizes, train_mean,
             color='blue', marker='o',
             markersize=5, label='training accuracy')

    plt.fill_between(train_sizes,
                     train_mean + train_std,
                     train_mean - train_std,
                     alpha=0.15, color='blue')

    plt.plot(train_sizes, test_mean,
             color='green', linestyle='--',
             marker='s', markersize=5,
             label='validation accuracy')

    plt.fill_between(train_sizes,
                     test_mean + test_std,
                     test_mean - test_std,
                     alpha=0.15, color='green')

    plt.grid(True)
    plt.xlabel('Number of training samples')
    plt.ylabel('Accuracy')
    plt.legend(loc='lower right')
    plt.ylim([0.5, 1.03])
    plt.tight_layout()
    plt.savefig('learning_curve.png', dpi=600)
    plt.close()

    # Results with different parameters: k
    cv_scores = cross_val_score(nb.KNeighborsClassifier(n_neighbors=1), X=X_train, y=y_train, cv=10)
    print("Accuracy 1 neighbour:", np.mean(cv_scores))

    cv_scores = cross_val_score(nb.KNeighborsClassifier(n_neighbors=3), X=X_train, y=y_train, cv=10)
    print("Accuracy 3 neighbours:", np.mean(cv_scores))

    cv_scores = cross_val_score(nb.KNeighborsClassifier(n_neighbors=5), X=X_train, y=y_train, cv=10)
    print("Accuracy 5 neighbours:", np.mean(cv_scores))

    cv_scores = cross_val_score(nb.KNeighborsClassifier(n_neighbors=7), X=X_train, y=y_train, cv=10)
    print("Accuracy 7 neighbours:", np.mean(cv_scores))

    cv_scores = cross_val_score(nb.KNeighborsClassifier(n_neighbors=9), X=X_train, y=y_train, cv=10)
    print("Accuracy 9 neighbours:", np.mean(cv_scores))

    # Results with different parameters: k and distance weighting
    cv_scores = cross_val_score(nb.KNeighborsClassifier(n_neighbors=1, weights='distance'), X=X_train, y=y_train, cv=10)
    print("Accuracy 1 neighbour: and distance weighting:", np.mean(cv_scores))

    cv_scores = cross_val_score(nb.KNeighborsClassifier(n_neighbors=3, weights='distance'), X=X_train, y=y_train, cv=10)
    print("Accuracy 3 neighbour: and distance weighting:", np.mean(cv_scores))

    cv_scores = cross_val_score(nb.KNeighborsClassifier(n_neighbors=5, weights='distance'), X=X_train, y=y_train, cv=10)
    print("Accuracy 5 neighbour: and distance weighting:", np.mean(cv_scores))

    cv_scores = cross_val_score(nb.KNeighborsClassifier(n_neighbors=7, weights='distance'), X=X_train, y=y_train, cv=10)
    print("Accuracy 7 neighbour: and distance weighting:", np.mean(cv_scores))

    cv_scores = cross_val_score(nb.KNeighborsClassifier(n_neighbors=9, weights='distance'), X=X_train, y=y_train, cv=10)
    print("Accuracy 9 neighbour: and distance weighting:", np.mean(cv_scores))

    lr = []
    for ki in range(1, 30, 2):
        cv_scores = cross_val_score(nb.KNeighborsClassifier(n_neighbors=ki), X=X_train, y=y_train, cv=10)
        lr.append(np.mean(cv_scores))
    plt.plot(range(1, 30, 2), lr, 'b', label='No weighting')

    lr = []
    for ki in range(1, 30, 2):
        cv_scores = cross_val_score(nb.KNeighborsClassifier(n_neighbors=ki, weights='distance'), X=X_train, y=y_train,
                                    cv=10)
        lr.append(np.mean(cv_scores))

    plt.plot(range(1, 30, 2), lr, 'r', label='Weighting')
    plt.xlabel('k')
    plt.ylabel('Accuracy')
    plt.legend(loc='upper right')
    plt.grid()
    plt.tight_layout()
    plt.savefig("best_parameters.png")
    plt.close()

    params = {'n_neighbors': list(range(1, 30, 2)), 'weights': ('distance', 'uniform')}
    knc = nb.KNeighborsClassifier()
    clf = GridSearchCV(knc, param_grid=params, cv=10, n_jobs=-1)  # If cv is integer, by default is Stratifyed
    clf.fit(X_train, y_train)
    print("Best Params=", clf.best_params_, "Accuracy=", clf.best_score_)

    # best model
    parval = clf.best_params_
    knc = nb.KNeighborsClassifier(n_neighbors=parval['n_neighbors'], weights=parval['weights'])
    knc.fit(X_train, y_train)
    pred = knc.predict(X_test)
    best_confmat = sklearn.metrics.confusion_matrix(y_test, pred)
    best_accuracy = sklearn.metrics.accuracy_score(y_test, pred)
    f1_measure = sklearn.metrics.f1_score(y_test, pred)
    print("Accuracy of the best model: %s" % best_accuracy)
    print("F1-measure of the best model: %s" % f1_measure)
    print("Confmat of the best model: %s" % best_confmat)

    # Confusion matrix plot
    fig, ax = plt.subplots(figsize=(2.5, 2.5))
    ax.matshow(best_confmat, cmap=plt.cm.Blues, alpha=0.3)
    for i in range(best_confmat.shape[0]):
        for j in range(best_confmat.shape[1]):
            ax.text(x=j, y=i, s=best_confmat[i, j], va='center', ha='center', fontsize=7)

    plt.xlabel('Predicted label')
    plt.ylabel('True label')

    plt.tight_layout()
    plt.savefig('ConMatrix_BestModel.png', dpi=600)
    plt.close()

    # score with cross validation
    predicted = cross_val_predict(knc, X=X, y=y, cv=10)
    print("\nBest model with CV")
    print("\n Best model confusion matrix with CV:")
    best_confmat_cv = sklearn.metrics.confusion_matrix(y, predicted)
    print(best_confmat_cv)
    print("Best accuracy score with CV: %s" % sklearn.metrics.accuracy_score(y, predicted))
    print("F1-measure of the best model with CV: %s" % sklearn.metrics.f1_score(y, predicted))
    scores = cross_val_score(knc, X=X, y=y, cv=10)
    print("Scores of best model with CV: %s" % scores)
    print("Mean of scores %s" % np.mean(scores))
    print("std of scores %s" % np.std(scores))
    # Confusion matrix plot
    fig, ax = plt.subplots(figsize=(2.5, 2.5))
    ax.matshow(best_confmat_cv, cmap=plt.cm.Blues, alpha=0.3)
    for i in range(best_confmat_cv.shape[0]):
        for j in range(best_confmat_cv.shape[1]):
            ax.text(x=j, y=i, s=best_confmat_cv[i, j], va='center', ha='center', fontsize=7)

    plt.xlabel('Predicted label')
    plt.ylabel('True label')

    plt.tight_layout()
    plt.savefig('ConMatrix_BestModel_withCV.png', dpi=600)
    plt.close()

    # same with feature selection and cross validation
    aux_accuracy = 0
    best_k_acc = 0
    aux_fm = 0
    best_k_fm = 0
    for k_features in range(2, 31):
        X_fs = SelectKBest(mutual_info_classif, k=k_features).fit_transform(X, y)
        predicted = cross_val_predict(knc, X=X_fs, y=y, cv=10)
        new_acc = sklearn.metrics.accuracy_score(y, predicted)
        if aux_accuracy <= new_acc:
            aux_accuracy = new_acc
            best_k_acc = k_features
        new_fm = sklearn.metrics.f1_score(y, predicted)
        if aux_fm <= new_fm:
            aux_fm = new_fm
            best_k_fm = k_features

    print("best feature selection:")
    print("best k accuracy: %s features, %s accuracy" % (best_k_acc, aux_accuracy))
    print("best k fmeasure: %s features, %s measure" % (best_k_fm, aux_fm))

    X_fs = SelectKBest(mutual_info_classif, k=best_k_acc).fit_transform(X, y)

    lr = []
    for ki in range(1, 30, 2):
        cv_scores = cross_val_score(nb.KNeighborsClassifier(n_neighbors=ki), X=X_fs, y=y, cv=10)
        lr.append(np.mean(cv_scores))
    plt.plot(range(1, 30, 2), lr, 'b', label='No weighting')

    lr = []
    for ki in range(1, 30, 2):
        cv_scores = cross_val_score(nb.KNeighborsClassifier(n_neighbors=ki, weights='distance'), X=X_fs, y=y,
                                    cv=10)
        lr.append(np.mean(cv_scores))

    plt.plot(range(1, 30, 2), lr, 'r', label='Weighting')
    plt.xlabel('k')
    plt.ylabel('Accuracy')
    plt.legend(loc='upper right')
    plt.grid()
    plt.tight_layout()
    plt.savefig("best_parameters_fselection.png")
    plt.close()

    params = {'n_neighbors': list(range(1, 30, 2)), 'weights': ('distance', 'uniform')}
    knc = nb.KNeighborsClassifier()
    clf = GridSearchCV(knc, param_grid=params, cv=10, n_jobs=-1)
    clf.fit(X_fs, y)
    print("Best Params=", clf.best_params_, "Accuracy=", clf.best_score_)
    parval = clf.best_params_
    knc = nb.KNeighborsClassifier(n_neighbors=parval['n_neighbors'], weights=parval['weights'])
    knc.fit(X_train, y_train)

    predicted = cross_val_predict(knc, X=X_fs, y=y, cv=10)
    print("\nBest model with fselection and CV")
    print("\n Best model confusion matrix with fselection and CV:")
    best_confmat_cv = sklearn.metrics.confusion_matrix(y, predicted)
    print(best_confmat_cv)
    print("Best accuracy score with fselection and CV: %s" % sklearn.metrics.accuracy_score(y, predicted))
    print("F1-measure of the best model with fselection and  CV: %s" % sklearn.metrics.f1_score(y, predicted))
    scores = cross_val_score(knc, X=X, y=y, cv=10)
    print("Scores of best model with fselection and CV: %s" % scores)
    print("Mean of scores %s" % np.mean(scores))
    print("std of scores %s" % np.std(scores))
    # Confusion matrix plot
    fig, ax = plt.subplots(figsize=(2.5, 2.5))
    ax.matshow(best_confmat_cv, cmap=plt.cm.Blues, alpha=0.3)
    for i in range(best_confmat_cv.shape[0]):
        for j in range(best_confmat_cv.shape[1]):
            ax.text(x=j, y=i, s=best_confmat_cv[i, j], va='center', ha='center', fontsize=7)

    plt.xlabel('Predicted label')
    plt.ylabel('True label')

    plt.tight_layout()
    plt.savefig('ConMatrix_BestModel_fselection_withCV.png', dpi=600)
    plt.close()


if __name__ == '__main__':
    knn("clean_student_por.csv")

