#'
#' @title assignExpand aux function to expand array objects if indices outstrip present dimensions
#' 
#' @description This function was written to emulate matlab behavior for defining vector or matrix dimensions on the fly in the moment of assigning. Say we have an empty object \code{NULL}, then we can assign to as-yet undefined indices by calling this function. Likewise for matrices that are iteratively constructed, but whose ultimate dimensions are awkward to predetermine. This function is a cheap hack and should only be used when doing unreflective fast implementations of the matlab legacy code, since this is customary practice in that code. In general, one should calculate the dimensions of an object before filling it up! This should only work for two-dimension arrays (matrices). Not higher dimensions and not data.frames. Again, don't ever use this function in a final R implementation!
#' 
#' @param vec the vector or matrix you're assigning to
#' @param i row or length index. If missing, assignment is over all rows.
#' @param j column index. If missing, assignment is over all columns
#' @param x the thing you're assigning
#' @param fill space in new dimensions that is not directly assigned to. default NA. could also be 0, or FALSE, or something like that.
#' @param drop logical. If the resulting matrix has only one column or one row, shall we convert to vector?
#' @export
#' 
#' @importFrom compiler cmpfun
#'  
#' @examples
#' (A <- assignExpand(NULL,2,5,"x"))
#' (A <- assignExpand(NULL,2:4,5:10,1:18,0))
#' B <- matrix(1:18,nrow=3,ncol=6)
#' (A <- assignExpand(NULL,2:4,5:10,B))
#' (A <- assignExpand(B,1:3,7,1:3))
#' (A <- assignExpand(B,,7,1:3)) # all rows via omission
#' 
assignExpand <- cmpfun(function(vec = NA, i, j, x, fill = NA, drop = TRUE){
  dims <- dim(vec)
  VTF  <- is.null(dims)
  if (VTF){
    NTF <- is.na(NA)
    vec <- as.matrix(VTF)
    vec[NTF] <- fill
  }
  dims  <- dim(vec)
  if (missing(i)){
    i <- 1:nrow(vec)
  }
  if(missing(j)){
    j <- 1:ncol(vec)
  }
  if (dims[1] < max(i)){
    vec <- rbind(vec, matrix(fill,nrow = (max(i) - nrow(vec)), ncol = ncol(vec)))
  }
  if (dims[2] < max(j)){
    vec <- cbind(vec, matrix(fill,nrow=nrow(vec), ncol = (max(j) - ncol(vec))))
  }
  vec[i,j] <- x
  if (drop & any(dim(vec) == 1)){
    dim(vec) <- NULL
  }
  vec
})

