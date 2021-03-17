# Key points
# 𝑋1,...,𝑋𝑝  denote the features,  𝑌  denotes the outcomes, and  𝑌̂   denotes the predictions.
# Machine learning prediction tasks can be divided into categorical and continuous outcomes. We refer to these as classification and prediction, respectively.

# Key points
# 𝑌𝑖  = an outcome for observation or index i.
# We use boldface for  𝐗_𝐢  to distinguish the vector of predictors from the individual predictors  𝑋𝑖,1,...,𝑋𝑖,784 .
# When referring to an arbitrary set of features and outcomes, we drop the index i and use  𝑌  and bold  𝐗 .
# Uppercase is used to refer to variables because we think of predictors as random variables.
# Lowercase is used to denote observed values. For example,  𝐗=𝐱 .

# True: A key feature of machine learning is that the algorithms are built with data.
# True: In machine learning, we build algorithms that take feature values (X) and train a model using known outcomes (Y) that is then used to predict outcomes when presented with features without known outcomes.

# library(caret)

# Key points
# Note: the set.seed() function is used to obtain reproducible results. If you have R 3.6 or later, please use the sample.kind = "Rounding" argument whenever you set the seed for this course.
# To mimic the ultimate evaluation process, we randomly split our data into two — a training set and a test set — and act as if we don’t know the outcome of the test set. We develop algorithms using only the training set; the test set is used only for evaluation.
# The createDataPartition()  function from the caret package can be used to generate indexes for randomly splitting data.
# Note: contrary to what the documentation says, this course will use the argument p as the percentage of data that goes to testing. The indexes made from createDataPartition() should be used to create the test set. Indexes should be created on the outcome and not a predictor.
# The simplest evaluation metric for categorical outcomes is overall accuracy: the proportion of cases that were correctly predicted in the test set.