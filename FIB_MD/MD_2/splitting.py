import pandas as pd
import numpy as np
import random

def split(path):
	df = pd.read_csv("dataset_clean/"+path)
	trainingDataframe = df.sample(int(len(df.index)*0.75))
	validationDataframe = pd.concat([df,trainingDataframe]).drop_duplicates(keep=False)
	if path == "clean_student_por.csv":
		trainingDataframe.to_csv("dataset_split/crossvalidation_student_por.csv")
		validationDataframe.to_csv("dataset_split/testing_student_por.csv")
	else:
		trainingDataframe.to_csv("dataset_split/crossvalidation_student_mat.csv")
		validationDataframe.to_csv("dataset_split/testing_student_mat.csv")



if __name__ == '__main__':
	a = input("What dataset do you want to preprocess?\n 1-por\n 2-mat\n")
	if a == "1":
		split("clean_student_por.csv")
	elif a == "2":
		split("clean_student_mat.csv")
	else:
		print("Incorrect input")
