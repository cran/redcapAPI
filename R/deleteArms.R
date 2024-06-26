#' @describeIn armsMethods Delete arms from a project.
#' @order 3
#' @export

deleteArms <- function(rcon, 
                       arms, 
                       ...){
  UseMethod("deleteArms")
}


#' @rdname armsMethods
#' @order 6
#' @export

deleteArms.redcapApiConnection <- function(rcon, 
                                           arms,
                                           ...,
                                           error_handling = getOption("redcap_error_handling"), 
                                           config         = list(), 
                                           api_param      = list()){
  
  if (is.numeric(arms)) arms <- as.character(arms)

   ##################################################################
  # Argument Validation
  
  coll <- checkmate::makeAssertCollection()
  
  checkmate::assert_character(arms, 
                              any.missing = FALSE,
                              add = coll)
  
  error_handling <- checkmate::matchArg(x = error_handling, 
                                        choices = c("null", "error"), 
                                        .var.name = "error_handling",
                                        add = coll)
  
  checkmate::assert_list(x = config, 
                         names = "named", 
                         add = coll)
  
  checkmate::assert_list(x = api_param, 
                         names = "named", 
                         add = coll)
  
  checkmate::reportAssertions(coll)
  
  Arms <- rcon$arms()
  
  checkmate::assert_subset(x = arms, 
                           choices = as.character(Arms$arm_num), 
                           add = coll)
  
  checkmate::reportAssertions(coll)
  
  ###################################################################
  # Make API Body List
  body <- c(list(token = rcon$token,
                 content = "arm",
                 action = "delete"),
            vectorToApiBodyList(arms, "arms"))

  body <- body[lengths(body) > 0]
  
  ###################################################################
  # Call the API
  if (length(arms) > 0){ # Skip the call if there are no arms to delete
    response <- makeApiCall(rcon, 
                            body = c(body, api_param), 
                            config = config)
    rcon$flush_arms()
    rcon$flush_events()
    rcon$flush_projectInformation()
    if (response$status_code != 200) return(redcapError(response, error_handling))
  } else {
    response <- "0"
  }
  
  invisible(as.character(response))
}
