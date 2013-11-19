


#'
#' @title saveRbirths2M reformat R LDB Births internal data.frame to matlab format and save out.
#' 
#' @description this function does as promised. Given the standard R data.frame as created by \code{readInputDB()}, it'll reshuffle columns and change character values to integer or numeric as required to meet the LDB matlab expectations. R scripts use column names as identifiers, whereas matlab scripts use indices. The matlab code rearranges indices as well, and sheds some columns, which necessitates specialty functions such as this.
#' 
#' @param BirthsRDF is the R Births data.frame, as returned by \code{readInputDB()}, and used downstream. It gets converted to a matrix according to the HMD matlab legacy standards and saved out as a matlab file
#' @param full.path.mat the full path to where you want the matlab matrix saved, including the \code{.mat} suffix.
#' 
#' @importFrom R.matlab writeMat
#' 
#' @export
#' 

saveRbirths2M <- function(BirthsRDF, full.path.mat){
  
  BirthsM                 <- BirthsRDF[,c("Area", "Sex", "Year", "Births", "YearReg", "RefCode", 
                              "Access", "NoteCode1", "NoteCode2", "NoteCode3")]
                          
  BirthsM$Sex             <- ifelse(BirthsM$Sex == "m", 1,
                                ifelse(BirthsM$Sex == "f", 2, NA))
  BirthsM$Access <- ifelse(BirthsM$Access == "O", 1, 0)
  
  BirthsM <- as.matrix(BirthsM)
  
  writeMat(full.path.mat, deaths = BirthsM) 
}

