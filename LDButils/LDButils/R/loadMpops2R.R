#'
#' @title loadMpops2R translate the R internal Pop data.frame to matlab LDB standard
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

loadMpops2R <- function(full.path.mat, PopName = "HUN"){
  # read in
  PopR                <- readMat(full.path.mat)[[1]]
  PopR[PopR == -1] <- NA
  PopR                <- as.data.frame(PopR)
 
  # give colnames
  if (ncol(PopR) == 14){
    colnames(PopR) <- c("Area", "Sex", "Age", "AgeInterval","Year","Month",
      "Day","Population","Type","RefCode","Access","NoteCode1",
      "NoteCode2","NoteCode3")
    PopR$LDB <- 1
  }
  if (ncol(PopR) == 15){
    colnames(PopR) <- c("Area", "Sex", "Age", "AgeInterval","Year","Month",
      "Day","Population","Type","RefCode","Access","NoteCode1",
      "NoteCode2","NoteCode3","LDB")
  }
  
  # add PopName
  PopR$PopName <- PopName
  
  PopR$Sex             <- ifelse(PopR$Sex == 1, "m",
                                  ifelse(PopR$Sex == 2, "f", NA))
  type.rec             <- c("C","O","R","E")
  names(type.rec)      <- 0:3
  PopR$Type            <- type.rec[as.character(PopR$Type)]
  
  PopR$AgeInterval[PopR$AgeInterval == 0 & !is.na(PopR$AgeInterval)] <- "+"
  PopR$AgeIntervali                          <- as.integer(PopR$AgeInterval)
  
  PopR$Age[is.na(PopR$Age)]               <- "UNK"
  PopR$Age[PopR$Age == 300]               <- "TOT"
  PopR$Agei                               <- as.integer(PopR$Age)
  PopR$Access                             <- ifelse(PopR$Access == 1, "O", "C")
  
  # send back ordered properly
  invisible(PopR[, c("PopName", "Area", "Sex", "Age", "AgeInterval", "Type", "Day", 
    "Month", "Year", "RefCode", "Access", "Population", "NoteCode1", 
    "NoteCode2", "NoteCode3", "LDB", "Agei", "AgeIntervali")])
}
