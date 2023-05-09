# Peer-graded Assignment: Programming Assignment 2: Lexical Scoping

## For this assignment, you need to do the following:
* Write makeCacheMatrix. 
* Write cacheSolve.
* Fork the [ProgrammingAssignment2](https://github.com/rdpeng/ProgrammingAssignment2) repo.
* Commit and push.
* Copy and paste the link to the repo.

## To pass the assignment, you need to do the following:
* Check 1: copy and paste the link to your completed R code or repo. 
* Check 2: your repo contains at least one commit. 
* Check 3: Submit a valid SHA-1 hash identifier corresponding to the commit. 

### Functions:

#### Function 1: makeCacheMatrix

```{r}
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
```

#### Function 2: cacheSolve

```{r}
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
```

#### Result run:
```{r}
mat <- makeCacheMatrix(matrix(1:4, 2, 2))
mat$get()
cacheSolve(mat)
mat$getInverse()
mat$set(matrix(c(2, 2, 1, 4), 2, 2))
mat$get()
mat$getInverse()
cacheSolve(mat)
mat$getInverse()
```
