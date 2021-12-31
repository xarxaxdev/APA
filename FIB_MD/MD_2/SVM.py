import matplotlib.pyplot as plt  # Per mostrar plots
import numpy as np  # Llibreria matemÃƒ tica
import pandas as pd  # Optional: good package for manipulating data
import sklearn  # Llibreia de DM
import sklearn.model_selection as cv  # Pel Cross-validation
from sklearn.metrics import classification_report
from sklearn.model_selection import GridSearchCV
from sklearn.preprocessing import MinMaxScaler
from sklearn.svm import SVC
import warnings


def plot_confmat(confmat):
    fig, ax = plt.subplots(figsize=(2.5, 2.5))
    ax.matshow(confmat, cmap=plt.cm.Blues, alpha=0.3)
    for i in range(confmat.shape[0]):
        for j in range(confmat.shape[1]):
            ax.text(x=j, y=i, s=confmat[i, j], va='center', ha='center', fontsize=7)

    plt.xlabel('Predicted label')
    plt.ylabel('True label')

    plt.tight_layout()
    plt.show()

def cross_validation(x_train, x_test, y_train, y_test):

    c_list = [0.01, 0.1, 1, 10, 100, 1000]

    tuned_parameters = [{'kernel': ['rbf'], 'gamma': [1e-1, 1e-2],
						 'C': c_list},
						{'kernel': ['linear'], 'C': c_list}]
    scores = ['precision_macro', 'recall_macro', 'f1']

    for score in scores:
        print("# Tuning hyper-parameters for %s" % score)
        print()

        clf = GridSearchCV(SVC(), tuned_parameters, cv=5,
						   scoring=score)

        clf.fit(x_train, y_train)

        print("Best parameters set found on development set:")
        print()
        print(clf.best_params_)
        print()
        print("Grid scores on development set:")
        print()
        means = clf.cv_results_['mean_test_score']
        stds = clf.cv_results_['std_test_score']
        parameters = clf.cv_results_['params']

        maxC = [max(means[0],means[1],means[12]), max(means[2],means[3],means[13]), max(means[4],means[5],means[14]), max(means[6],means[7],means[15]),
                max(means[8], means[9], means[16]),max(means[10],means[11],means[17])]

        plt.semilogx(c_list, maxC)
        plt.show()

        for mean, std, params in zip(means, stds, parameters):
            print("%0.3f (+/-%0.03f) for %r"
				  % (mean, std * 2, params))
        print()

        print("Detailed classification report:\n")
        print("The model is trained on the full development set.")
        print("The scores are computed on the full evaluation set.\n")
        y_true, y_pred = y_test, clf.predict(x_test)
        print(classification_report(y_true, y_pred))
        print()

    return clf

def svm():
    # READ THE DATASET
    df = pd.read_csv("clean_student_por.csv")
    # target values
    y = df['Passed'].values
    # divide data in train and test
    x = df.values[:,0:30].astype('float32')
    print(df.describe())
    (x_train, x_test, y_train, y_test) = cv.train_test_split(x, y, test_size=.4, stratify = y, random_state=1)

    # scaler = StandardScaler().fit(X_train)
    # scale the data in values (-1, 1)
    scaler = MinMaxScaler(feature_range=(-1, 1)).fit(x_train)

    # Apply the normalization trained in training data in both training and test sets
    x_train = scaler.transform(x_train)
    x_test = scaler.transform(x_test)

    # using a linear kernel for the SVM
    knc = SVC(kernel='linear')

    # training the model
    knc.fit(x_train, y_train)

    # making a prediction for our test values
    pred = knc.predict(x_test)

    # comparing the results of our prediction with the truth
    print("Confusion matrix on test set:\n",sklearn.metrics.confusion_matrix(y_test, pred))
    plot_confmat(sklearn.metrics.confusion_matrix(y_test, pred))

    # accuracy of:
    print("\nAccuracy on test set: ",sklearn.metrics.accuracy_score(y_test, pred))

    # Applying a 5x5 cross-validation to find the best kernel and its parameters
    model = cross_validation(x_train, x_test, y_train, y_test)
    best_c = model.best_params_.get('C')
    best_gamma = model.best_params_.get('gamma')
    best_kernel = model.best_params_.get('kernel')

    knc = model.best_estimator_
    knc.fit(x_train, y_train)
    prediction = knc.predict(x_test)

    confmat = sklearn.metrics.confusion_matrix(y_test, prediction)

    plot_confmat(confmat)

    print("\nConfusion matrix on test set:\n", confmat)
    print("\nAccuracy on test set: ", sklearn.metrics.accuracy_score(y_test, prediction))
    print("\nBest kernel function found: ", best_kernel)
    print("\nBest value of parameter gamma found: ", best_gamma)
    print("\nBest value of parameter C found: ", best_c)
    print("\nNumber of supports: ", np.sum(knc.n_support_), "(", np.sum(np.abs(knc.dual_coef_) == best_c), "of them have slacks )")
    print("Prop. of supports: ", np.sum(knc.n_support_) / x_train.shape[0])


	
"""
	training_scores, test_scores = validation_curve(SVC(kernel='linear'), X_train, y_train, param_name="C", param_range=Cs,cv=10)
	plot_validation_curve(range(len(Cs)), training_scores, test_scores)
	plt.xticks(range(len(Cs)), Cs,rotation='vertical');
	plt.ylim([0.6, 1])
	plt.show()
"""
if __name__ == '__main__':
    warnings.filterwarnings("ignore")
    svm()