\name{assignExpand}
\alias{assignExpand}
\title{assignExpand aux function to expand array objects if indices outstrip present dimensions}
\usage{
  assignExpand(vec = NA, i, j, x, fill = NA, drop = TRUE)
}
\arguments{
  \item{vec}{the vector or matrix you're assigning to}

  \item{i}{row or length index. If missing, assignment is
  over all rows.}

  \item{j}{column index. If missing, assignment is over all
  columns}

  \item{x}{the thing you're assigning}

  \item{fill}{space in new dimensions that is not directly
  assigned to. default NA. could also be 0, or FALSE, or
  something like that.}

  \item{drop}{logical. If the resulting matrix has only one
  column or one row, shall we convert to vector?}
}
\description{
  This function was written to emulate matlab behavior for
  defining vector or matrix dimensions on the fly in the
  moment of assigning. Say we have an empty object
  \code{NULL}, then we can assign to as-yet undefined
  indices by calling this function. Likewise for matrices
  that are iteratively constructed, but whose ultimate
  dimensions are awkward to predetermine. This function is
  a cheap hack and should only be used when doing
  unreflective fast implementations of the matlab legacy
  code, since this is customary practice in that code. In
  general, one should calculate the dimensions of an object
  before filling it up! This should only work for
  two-dimension arrays (matrices). Not higher dimensions
  and not data.frames. Again, don't ever use this function
  in a final R implementation!
}
\examples{
(A <- assignExpand(NULL,2,5,"x"))
(A <- assignExpand(NULL,2:4,5:10,1:18,0))
B <- matrix(1:18,nrow=3,ncol=6)
(A <- assignExpand(NULL,2:4,5:10,B))
(A <- assignExpand(B,1:3,7,1:3))
(A <- assignExpand(B,,7,1:3)) # all rows via omission
}

