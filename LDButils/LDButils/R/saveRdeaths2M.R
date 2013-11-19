#'
#' @title saveRdeaths2M reformat R LDB Deaths internal data.frame to matlab format and save out.
#' 
#' @description this function does as promised. Given the standard R data.frame as created by \code{readInputDB()}, it'll reshuffle columns and change character values to integer or numeric as required to meet the LDB matlab expectations. R scripts use column names as identifiers, whereas matlab scripts use indices. The matlab code rearranges indices as well, and sheds some columns, which necessitates specialty functions such as this.
#' 
#' @param DeathsRDF is the R Deaths data.frame, as returned by \code{readInputDB()}, and used downstream. It gets converted to a matrix according to the HMD matlab legacy standards and saved out as a matlab file
#' @param full.path.mat the full path to where you want the matlab matrix saved, including the \code{.mat} suffix.
#' 
#' @importFrom R.matlab writeMat
#' 
#' @export
#' 

saveRdeaths2M <- function(DeathsRDF, full.path.mat){
  DeathsM                 <- DeathsRDF[,c("Area", "Sex", "Year", "Age", "Lexis", "YearInterval",
      "AgeInterval", "YearReg", "Deaths", "RefCode", "Access",
      "NoteCode1", "NoteCode2", "NoteCode3", "LDB")]
  DeathsM$Sex             <- ifelse(DeathsM$Sex == "m", 1,
    ifelse(DeathsM$Sex == "f", 2, NA))
  Lexis.rec               <- 1:6
  names(Lexis.rec)        <- c("TL", "TU", "RR", "VV", "VH", "RV")
  DeathsM$Lexis           <- Lexis.rec[DeathsM$Lexis]
  
  DeathsM$AgeInterval[DeathsM$AgeInterval == "+"] <- 0
  DeathsM$AgeInterval                             <- as.integer(DeathsM$AgeInterval)
  
  DeathsM$Age[DeathsM$Age == "UNK"]               <- -1
  DeathsM$Age[DeathsM$Age == "TOT"]               <- 300
  DeathsM$Age                                     <- as.integer(DeathsM$Age)
  DeathsM$Access <- ifelse(DeathsM$Access == "O", 1, 0)
  
  DeathsM <- as.matrix(DeathsM)
  
  writeMat(full.path.mat, deaths = DeathsM) 
}

