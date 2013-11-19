\name{saveRdeaths2M}
\alias{saveRdeaths2M}
\title{saveRdeaths2M reformat R LDB Deaths internal data.frame to matlab format and save out.}
\usage{
  saveRdeaths2M(DeathsRDF, full.path.mat)
}
\arguments{
  \item{DeathsRDF}{is the R Deaths data.frame, as returned
  by \code{readInputDB()}, and used downstream. It gets
  converted to a matrix according to the HMD matlab legacy
  standards and saved out as a matlab file}

  \item{full.path.mat}{the full path to where you want the
  matlab matrix saved, including the \code{.mat} suffix.}
}
\description{
  this function does as promised. Given the standard R
  data.frame as created by \code{readInputDB()}, it'll
  reshuffle columns and change character values to integer
  or numeric as required to meet the LDB matlab
  expectations. R scripts use column names as identifiers,
  whereas matlab scripts use indices. The matlab code
  rearranges indices as well, and sheds some columns, which
  necessitates specialty functions such as this.
}

