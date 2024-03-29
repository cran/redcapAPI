  #############################################################################
 #
# To properly do a full integration test a REDCap
# instance is required that matches the intended test cases.
#
# This helper will pull the required values from a keyring
# similar to how `rccola` works for security purposes.
# This package cannot depend on `rccola` without creating 
# a circular dependency so minimal code is copied locally
# 
# To duplicate our test database see: inst/extdata
#
# Create a keyring: 
# This will create a keyring "API_KEYs"
# It will name it the service "redcapAPI"
# It will ask to save an API_KEY in this ring (there can be multiple!)
#   of the name "TestRedcapAPI"
  
library(checkmate) # for additional expect_* functions.
library(keyring)
  
url <- "https://redcap.vanderbilt.edu/api/" # Our institutions REDCap instance

conns <- unlockREDCap(
  c(rcon ="TestRedcapAPI"), ## Change to rcon when satisfied with testing
 # c(rcon = "DataTypes"),        ## Delete this to change to primary project
  url=url, keyring='API_KEYs', 
  envir=globalenv())




