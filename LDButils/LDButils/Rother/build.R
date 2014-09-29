
# devtools calls to document and build this package

library(devtools)

devtools::document( "/data/commons/triffe/git/LDButils/LDButils/LDButils")
load_all("/data/commons/triffe/git/LDButils/LDButils/LDButils")
library(devtools)
install_github("LDButils","timriffe",subdir="LDButils/LDButils")
library(LDButils)
#build(pkg = "/data/commons/triffe/LexisDB_R/testing/LDButils",
#  path = "/data/commons/triffe/LexisDB_R/testing/")
#
#
#install.packages("/data/commons/triffe/LexisDB_R/testing/LDButils_0.0.tar.gz", 
#  repos = NULL, type="source")







