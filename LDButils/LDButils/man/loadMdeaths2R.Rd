\name{loadMdeaths2R}
\alias{loadMdeaths2R}
\title{loadMdeaths2R translate the R internal Deaths data.frame to matlab LDB standard}
\usage{
  loadMdeaths2R(full.path.mat, PopName = "HUN")
}
\arguments{
  \item{full.path.mat}{the full path to the matlab file
  containing only the given deaths matrix and including the
  \code{.mat} suffix}

  \item{PopName}{character. HMD country code, since matlab
  does not preserve this}
}
\description{
  this function does as promised. Given the standard
  numeric matrix used by the legacy matlab code and saved
  to a \code{.mat} file by matlab, it'll read it into R,
  give it colnames, convert columns as necessary, augment
  for the new R standard, and reorder the columns according
  to that returned by \code{readInputDB()} and used
  downstream in R. R scripts use column names as
  identifiers, whereas matlab scripts use indices. The
  matlab code rearranges indices as well, and sheds some
  columns, which necessitates specialty functions such as
  this.
}

