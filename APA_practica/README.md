# Pokemon dataset studying
This is a project done in the APA subject in FIB  (UPC Barcelona).

Before you can see the models and how they performed you must execute preprocessing.r (quick key with Rstudio = Ctrl + Shift + Enter)

Then to generate Learning and testing data you must do the same with splitting.r (quick key with Rstudio = Ctrl + Shift + Enter)

Finally to see how the models are generated and trained run the r scripts for each one(linear&SVM.r or MLP.r)

pokemon.csv is the original dataset file extracted from https://www.kaggle.com/davidrgp/pokedex 
pokemon_procesado.csv is the dataset after applying preprocessing
pokemonTraining.csv is the subset of the processed dataset that correspons to Learning
pokemonTesting.csv is the subset of the processed dataset that corresponds to Testing

### preprocessing.r
This file is the basic preprocessing we did together with the visualization of the data.
A couple variables were deleted since we didn't find them useful.
We converted 'type1' and 'type2' to dummy variables to better represent our dataset.
We converted 'egg_group1' and 'egg_group2' to dummy variables to better represent our dataset.
We converted abilities to dummy variables to better represent our dataset.
We rescaled all the numerical variales to correct skewness, kurtosis and then normalized them.
Besides that we plotted a lot of variable information.


### splitting.r
This file is necessary for create our learning data and testing data. Since our models are in
two separated files it's a good idea to create and save our sets separately.

### linear&SVM.r (4 models)
We fit the linear regression and the SVMs (Linear SVM, Quadratic SVM and RBF SVM).

### MLP.r (1 model)
We fit an MLP using keras, the state of the art library for deep learning.
