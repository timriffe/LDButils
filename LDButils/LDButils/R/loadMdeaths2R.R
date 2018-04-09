#'
#' @title loadMdeaths2R translate the R internal Deaths data.frame to matlab LDB standard
#' 
#' @description this function does as promised. Given the standard numeric matrix used by the legacy matlab code and saved to a \code{.mat} file by matlab, it'll read it into R, give it colnames, convert columns as necessary, augment for the new R standard, and reorder the columns according to that returned by \code{readInputDB()} and used downstream in R. R scripts use column names as identifiers, whereas matlab scripts use indices. The matlab code rearranges indices as well, and sheds some columns, which necessitates specialty functions such as this.
#' 
#' @param full.path.mat the full path to the matlab file containing only the given deaths matrix and including the \code{.mat} suffix
#' @param PopName character. HMD country code, since matlab does not preserve this
#' 
#' @importFrom  R.matlab readMat
#' 
#' @export
#' 

loadMdeaths2R <- function(full.path.mat, PopName = "HUN"){
  # read in
  DeathsR                <- readMat(full.path.mat)[[1]]
  DeathsR[DeathsR == -1] <- NA
  DeathsR                <- as.data.frame(DeathsR)
  # give colnames
  if (ncol(DeathsR) == 15){
    colnames(DeathsR) <- c("Area", "Sex", "Year", "Age", "Lexis", "YearInterval",
      "AgeInterval", "YearReg", "Deaths", "RefCode", "Access",
      "NoteCode1", "NoteCode2", "NoteCode3", "LDB")
  }
  if (ncol(DeathsR) == 14){
    colnames(DeathsR) <- c("Area", "Sex", "Year", "Age", "Lexis", "YearInterval",
      "AgeInterval", "YearReg", "Deaths", "RefCode", "Access",
      "NoteCode1", "NoteCode2", "NoteCode3")
    DeathsR$LDB <- 1
  }
  
  # add PopName
  DeathsR$PopName <- PopName
  
  # recode vars
  DeathsR                     
  Lexis.rec               <- c("TL", "TU", "RR", "VV", "VH", "RV")
  names(Lexis.rec)        <- 1:6 
  
  DeathsR$Lexis <- Lexis.rec[DeathsR$Lexis]
  
  DeathsR$Sex   <- ifelse(DeathsR$Sex == 1, "m",
    ifelse(DeathsR$Sex == 2, "f", NA))
  
  # TR 9-4-2018 
  # never read in TOT. It would just get removed anyway
  DeathsR                                       <- DeathsR[DeathsR$Age != 300]              
  DeathsR$Age[is.na(DeathsR$Age)]               <- "UNK"
  
  DeathsR$Agei                                  <- as.integer(DeathsR$Age)
  
  DeathsR$AgeInterval[DeathsR$AgeInterval == 0] <- "+"
  DeathsR$AgeIntervali                          <- as.integer(DeathsR$AgeInterval)
  
  DeathsR$Access <- ifelse(DeathsR$Access == 1, "O", "C")
  
  # send back ordered properly
  DeathsR[, c("PopName", "Area", "Year", "YearReg", "YearInterval", "Sex", 
      "Age", "AgeInterval", "Lexis", "RefCode", "Access", "Deaths", 
      "NoteCode1", "NoteCode2", "NoteCode3", "LDB", "Agei", "AgeIntervali"
    )]
}


