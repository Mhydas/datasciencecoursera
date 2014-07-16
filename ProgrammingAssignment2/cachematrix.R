## We are going to create 2 functions. The first will create a special matrix that has 4 functions
## associated with it. The matrix will actually become a list of the 4 functions, with various values
## being defined in the environment of the function itself. The second function will either pull the 
## matrixInverse object from the environment of the special matrix or it will calculate and return
## the inverse. It will then set the inverse to the value of matrixInverse so the next time the code
## is run, it will provide the value from the makeCacheMatrix function environment

## Create a matrix that has the following functions associated with it

makeCacheMatrix <- function(x = matrix()) {
        
        ## Assigns object matrixInverse to NULL 
        matrixInverse <- NULL
        
        ## The set function with 'y' as the arguement 
        set <- function(y) {
                ## Assigns 'y', which would be matrix itself, to 'x' in the parent environment
                x <<- y
                ## Assigns matrixInverse to NULL in the parent environment
                matrixInverse <<- NULL
        }
        
        ## Get function calls 'x', which does now exist in this environment. We assigned 'x' 
        ## in the Set function above. We return 'x'
        get <- function() x
        
        ## SetCache function receives the inverse of the matrix and sets it to matrixInverse in 
        ## parent environment, as it was previously assigned the value NULL
        setCache <- function(inverse) matrixInverse <<- inverse
        
        ## GetCache function returns the value of matrixInverse
        getCache <- function() matrixInverse
        
        ## Make sure these functions are a list to access them easily
        list(set = set, get = get, setCache = setCache, getCache = getCache)
}


## Create a fucntion to either return the already completed inverse of the matrix or get
## the inverse and return it. If this function had to calculate the inverse itself, it will
## then set the inverse so it does not have to be caculated again. 

cacheSolve <- function(x, ...) {
        
        ## Assign matrixInverse to be the value of x$getCache, which should be NULL the 1st time
        matrixInverse <- x$getCache()
        
        ## If matrixInverse is not NULL, then give the message below and return the value
        if(!is.null(matrixInverse)) {
                message("getting matrix inverse from cache")
                return(matrixInverse)
        }
        ## If matrixInverse is NULL, do the following:
        ## Assign the value of the special matrix to 'data'
        data <- x$get()
        
        ## Assign the inverse of the matrix to 'matrixInverse'
        matrixInverse <- solve(data, ...)
        
        ## Set matrixInverse within the special matrix
        x$setCache(matrixInverse)
       
        ## Return the inverse of the matrix     
        matrixInverse
}
