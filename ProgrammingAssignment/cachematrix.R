# Programming Assignment 2: Lexical Scoping
# Caching the Inverse of a Matrix


# makeCacheMatrix: This function creates a special "matrix" object that can
# cache its inverse.

makeCacheMatrix <- function(x = matrix()) {
  inv <- NULL
  set <- function(y) {
    x <<- y
    inv <<- NULL
  }
  get <- function() x
  setInverse <- function(inverse) inv <<- inverse
  getInverse<- function() inv
  list(set = set, get = get,
       setInverse = setInverse,
       getInverse = getInverse)
}


# cacheSolve: This function computes the inverse of the special "matrix"
# returned by makeCacheMatrix above. If the inverse has already been calculated
# (and the matrix has not changed), then the cachesolve should retrieve the
# inverse from the cache.

cacheSolve <- function(x, ...) {
  inv <- x$getInverse()
  if(!is.null(inv)) {
    message("getting cached data")
    return(inv)
  }
  data <- x$get()
  inv <- solve(data, ...)
  x$setInverse(inv)
  inv
}

mat <- makeCacheMatrix(matrix(1:4, 2, 2))
mat$get()
cacheSolve(mat)
mat$getInverse()
mat$set(matrix(c(2, 2, 1, 4), 2, 2))
mat$get()
mat$getInverse()
cacheSolve(mat)
mat$getInverse()

