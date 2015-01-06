#'
#' @title saveRpops2M reformat R LDB Pop internal data.frame to matlab format and save out.
#' 
#' @description this function does as promised. Given the standard R data.frame as created by \code{readInputDB()}, it'll reshuffle columns and change character values to integer or numeric as required to meet the LDB matlab expectations. R scripts use column names as identifiers, whereas matlab scripts use indices. The matlab code rearranges indices as well, and sheds some columns, which necessitates specialty functions such as this.
#' 
#' @param PopRDF is the R Pop data.frame, as returned by \code{readInputDB()}, and used downstream. It gets converted to a matrix according to the HMD matlab legacy standards and saved out as a matlab file
#' @param full.path.mat the full path to where you want the matlab matrix saved, including the \code{.mat} suffix.
#' 
#' @importFrom R.matlab writeMat
#' 
#' @export
#' 
# this function does as promised...
# PopRDF is the R Population data.frame, as returned by readInputDB(), and used downstream.
# it gets converted to a matrix according to the HMD matlab legacy standards and saved out 
# as a matlab file

# full.path.mat is the full path and file name, including the .mat suffix.

# nothing is returned, file is created.
saveRpops2M <- function(PopRDF, full.path.mat){
  PopM                 <- PopRDF[,c("Area", "Sex", "Age", "AgeInterval","Year","Month",
                                 "Day","Population","Type","RefCode","Access","NoteCode1",
                                 "NoteCode2","NoteCode3")] # PopName and LDB always removed
  PopM$Sex             <- ifelse(PopM$Sex == "m", 1,
                            ifelse(PopM$Sex == "f", 2, NA))
                                                  
  type.rec             <- 0:3
  names(type.rec)      <- c("C","O","R","E")
  PopM$Type            <- type.rec[PopM$Type]
  
  PopM$AgeInterval[PopM$AgeInterval == "+"] <- 0
  PopM$AgeInterval                          <- as.integer(PopM$AgeInterval)
  
  PopM$Age[PopM$Age == "UNK"]               <- -1
  PopM$Age[PopM$Age == "TOT"]               <- 300
  PopM$Age                                  <- as.integer(PopM$Age)
  PopM$Access          <- ifelse(PopM$Access == "O", 1, 0)
  PopM$NoteCode1 <- suppressWarnings( as.integer( PopM$NoteCode1) )
  PopM$NoteCode2 <- suppressWarnings( as.integer( PopM$NoteCode2) )
  PopM$NoteCode3 <- suppressWarnings( as.integer( PopM$NoteCode3) )
  PopM$RefCode   <- suppressWarnings( as.integer( PopM$RefCode) )
  
  PopM                 <- as.matrix(PopM)
  PopM[is.na(PopM)]    <- -1
  writeMat(full.path.mat, population = PopM) 
}
