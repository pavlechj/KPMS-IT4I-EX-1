suppressMessages(library(kazaam))
source("mnist_read_mpi.R") # reads blocks of rows

## create shaq class distributed matrix from local pieces
sq_train = shaq(my_train)

## svd (shaq class: tall-skinny matrix)
train_svd = svd(sq_train, nu = 0, nv = 5)
comm.cat("kazaam top(5) singular values:", train_svd$d[1:5], "\n")

cp_train = allreduce(crossprod(my_train))
train_svd2 = eigen(cp_train)
comm.cat("direct top(5) singular values:", sqrt(train_svd2$values[1:5]), "\n")

finalize()
