import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns


def preprocess(path):
    df = pd.read_csv("dataset_original/" + path)

    # print(df.describe(include='all'))
    missing_data = df.isnull().any()
    # print(missing_data)

    '''
    # IF WE DELETE ALL THE ROWS WITH MISSING DATA THE DATASET WILL BE
    # TOO LITTLE, FROM 395 ROWS TO 112 AND FROM 649 TO 170
    df.replace("other", np.nan, inplace=True)
    df.dropna(axis=0, inplace = True)
    '''

    # Avg of the 3 grades into one new row to check correlations
    # Passed or Failed into another row
    for i, row in enumerate(df.itertuples()):
        avg = (getattr(row, "g1") + getattr(row, "g2") + getattr(row, "g3")) / 3
        if avg < 10:
            df.loc[i, "Grade"] = avg
            df.loc[i, "Passed"] = 0
        else:
            df.loc[i, "Grade"] = avg
            df.loc[i, "Passed"] = 1

    df.drop("g1", axis=1, inplace=True)
    df.drop("g2", axis=1, inplace=True)
    df.drop("g3", axis=1, inplace=True)

    # Hay muchos "other", sobretodo en mjob y fjob, como pueden ser variables no muy importantes se pueden quitar
    # las variables directamente
    # Reason y guardian si que tienen muchos menos other, se pueden quitar las rows con other y no se perderia mucho

    print("---------------- Frequency of values in columns with missing data (other) ----------------")
    print(df["mjob"].value_counts())
    print(df["fjob"].value_counts())
    print(df["reason"].value_counts())
    print(df["guardian"].value_counts())
    print("\n")

    # Ver si las variables son importantes o no
    print(
        "---------------- Grades grouped by the different values of the columns with missing data (other) ----------------")
    df_test = df[["mjob", "Grade"]]
    df_grp = df_test.groupby(["mjob"], as_index=False).mean()
    print(df_grp)
    df_test = df[["fjob", "Grade"]]
    df_grp = df_test.groupby(["fjob"], as_index=False).mean()
    print(df_grp)
    df_test = df[["reason", "Grade"]]
    df_grp = df_test.groupby(["reason"], as_index=False).mean()
    print(df_grp)
    df_test = df[["guardian", "Grade"]]
    df_grp = df_test.groupby(["guardian"], as_index=False).mean()
    print(df_grp)
    print("\n")

    # Para ver la correlacion entre absences y grade
    sns.regplot(x="absences", y="Grade", data=df)
    plt.ylim(0, )
    plt.savefig(path.replace(".csv", "") + "_correlation-absences-grade.png")

    for i, row in enumerate(df.itertuples()):
        if getattr(row, "school") == "GP":
            df.loc[i, "school"] = 1
        else:
            df.loc[i, "school"] = 2

        if getattr(row, "sex") == "F":
            df.loc[i, "sex"] = 1
        else:
            df.loc[i, "sex"] = 2

        if getattr(row, "address") == "U":
            df.loc[i, "address"] = 1
        else:
            df.loc[i, "address"] = 2

        if getattr(row, "famsize") == "GT3":
            df.loc[i, "famsize"] = 1
        else:
            df.loc[i, "famsize"] = 2

        if getattr(row, "pstatus") == "A":
            df.loc[i, "pstatus"] = 1
        else:
            df.loc[i, "pstatus"] = 2

        if getattr(row, "mjob") == "teacher":
            df.loc[i, "mjob"] = 1
        elif getattr(row, "mjob") == "health":
            df.loc[i, "mjob"] = 2
        elif getattr(row, "mjob") == "services":
            df.loc[i, "mjob"] = 3
        elif getattr(row, "mjob") == "at_home":
            df.loc[i, "mjob"] = 4
        else:
            df.loc[i, "mjob"] = 5

        if getattr(row, "fjob") == "teacher":
            df.loc[i, "fjob"] = 1
        elif getattr(row, "fjob") == "health":
            df.loc[i, "fjob"] = 2
        elif getattr(row, "fjob") == "services":
            df.loc[i, "fjob"] = 3
        elif getattr(row, "fjob") == "at_home":
            df.loc[i, "fjob"] = 4
        else:
            df.loc[i, "fjob"] = 5

        if getattr(row, "reason") == "home":
            df.loc[i, "reason"] = 1
        elif getattr(row, "reason") == "reputation":
            df.loc[i, "reason"] = 2
        elif getattr(row, "reason") == "course":
            df.loc[i, "reason"] = 3
        else:
            df.loc[i, "reason"] = 4

        if getattr(row, "guardian") == "mother":
            df.loc[i, "guardian"] = 1
        elif getattr(row, "guardian") == "father":
            df.loc[i, "guardian"] = 2
        else:
            df.loc[i, "guardian"] = 3

        if getattr(row, "guardian") == "mother":
            df.loc[i, "guardian"] = 1
        elif getattr(row, "guardian") == "father":
            df.loc[i, "guardian"] = 2
        else:
            df.loc[i, "guardian"] = 3

        absences = getattr(row, "absences")
        absences_normalized = (absences / df["absences"].max()) * 5
        absences_normalized = int(round(absences_normalized))
        df.loc[i, "absences"] = absences_normalized

        attributes = ["schoolsup", "famsup", "paid", "activities", "nursery", "higher", "internet", "romantic"]
        for attribute in attributes:
            if getattr(row, attribute):
                df.loc[i, attribute] = 1
            elif not getattr(row, attribute):
                df.loc[i, attribute] = 2

    df.drop("Grade", axis=1, inplace=True)
    df.to_csv("dataset_clean/clean_" + path)


if __name__ == '__main__':
    a = input("What dataset do you want to preprocess?\n 1-por\n 2-mat\n")
    if a == "1":
        preprocess("student_por.csv")
    elif a == "2":
        preprocess("student_mat.csv")
    else:
        print("Incorrect input")
