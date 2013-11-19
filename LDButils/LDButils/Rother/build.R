
# devtools calls to document and build this package

library(devtools)

document( "/data/commons/triffe/LexisDB_R/testing/LDButils")


load_all("/data/commons/triffe/LexisDB_R/testing/LDButils")


build(pkg = "/data/commons/triffe/LexisDB_R/testing/LDButils",
  path = "/data/commons/triffe/LexisDB_R/testing/")


install.packages("/data/commons/triffe/LexisDB_R/testing/LDButils_0.0.tar.gz", 
  repos = NULL, type="source")







