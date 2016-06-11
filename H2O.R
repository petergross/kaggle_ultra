#Use Case: MNIST 


# code example from H2O
library(h2o)

# single thread
h2o.init()

# multithreads
#h2o.init(nthreads = -1)

train_file <- "https://h2o-public-test-data.s3.amazonaws.com/bigdata/laptop/mnist/train.csv.gz"
test_file <- "https://h2o-public-test-data.s3.amazonaws.com/bigdata/laptop/mnist/test.csv.gz"

train <- h2o.importFile(train_file)
test <- h2o.importFile(test_file)

# To see a brief summary of the data, run the following command
#summary(train)
#summary(test)


y <- "C785"
x <- setdiff(names(train), y)

# We encode the response column as categorical for multinomial
#classification
train[,y] <- as.factor(train[,y])
test[,y] <- as.factor(test[,y])

# Train a Deep Learning model and valid
system.time(
  model_cv <- h2o.deeplearning(x = x,
                               y = y,
                               training_frame = train,
                               distribution = "multinomial",
                               activation = "Rectifier",
                               hidden = c(64),
                               #input_dropout_ratio = 0.2,
                               l1 = 1e-5,
                               epochs = 200)
)
