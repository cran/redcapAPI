% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/docsUserRoleAssignmentMethods.R,
%   R/exportUserRoleAssignments.R, R/importUserRoleAssignments.R
\name{userRoleAssignmentMethods}
\alias{userRoleAssignmentMethods}
\alias{exportUserRoleAssignments}
\alias{importUserRoleAssignments}
\alias{exportUserRoleAssignments.redcapApiConnection}
\alias{importUserRoleAssignments.redcapApiConnection}
\title{Export or Import User-Role Assignments}
\usage{
exportUserRoleAssignments(rcon, ...)

importUserRoleAssignments(rcon, data, ...)

\method{exportUserRoleAssignments}{redcapApiConnection}(
  rcon,
  ...,
  error_handling = getOption("redcap_error_handling"),
  config = list(),
  api_param = list()
)

\method{importUserRoleAssignments}{redcapApiConnection}(
  rcon,
  data,
  ...,
  error_handling = getOption("redcap_error_handling"),
  config = list(),
  api_param = list()
)
}
\arguments{
\item{rcon}{A \code{redcapConnection} object.}

\item{data}{\code{data.frame} with columns \code{username} and
\code{unique_role_name}. Each \code{username} must be unique.
Users without a \code{unique_role_name} will not be assigned to
a user role.}

\item{...}{Arguments to pass to other methods}

\item{error_handling}{\code{character(1)}. One of \code{c("error", "null")}.
An option for how to handle errors returned by the API.
see \code{\link[=redcapError]{redcapError()}}.}

\item{config}{A named \code{list}. Additional configuration parameters to pass to
\code{\link[httr:POST]{httr::POST()}}. These are appended to any parameters in
\code{rcon$config}.}

\item{api_param}{A named \code{list}. Additional API parameters to pass into the
body of the API call. This provides users to execute calls with options
that may not otherwise be supported by \code{redcapAPI}.}
}
\value{
\code{exportUserRoleAssignments} returns a data frame with the columns:\tabular{ll}{
    \tab  \cr
   \code{username} \tab Username of a user in the project. \cr
   \code{unique_role_name} \tab The unique role name to which the user is assigned. \cr
   \code{data_access_group} \tab The Data Access Group to which the user is assigned. \cr
}


\code{importUserRoleAssignments} invisibly returns the number of user roles
assignments added or modified.
}
\description{
These methods enable the user to export the user-role
assignments, add assignments, or modify existing assignments.
}
\section{Functions}{
\itemize{
\item \code{exportUserRoleAssignments()}: Export user-role assignments from a project.

\item \code{importUserRoleAssignments()}: Import user-role assignments to a project.

}}
\examples{
\dontrun{
unlockREDCap(connections = c(rcon = "project_alias"), 
             url = "your_redcap_url", 
             keyring = "API_KEYs", 
             envir = globalenv())
             
# Export user-role assignments
exportUserRoleAssignments(rcon)

# Import/modify a user-role assignment
NewData <- data.frame(username = "desired_user_name", 
                      unique_role_name = "KN3430U")
importUserRolesAssignments(rcon, 
                           data = NewData)
}

}
\seealso{
\code{\link[=exportUsers]{exportUsers()}}, \cr
\code{\link[=importUsers]{importUsers()}}, \cr
\code{\link[=deleteUsers]{deleteUsers()}}, \cr
\code{\link[=exportUserRoles]{exportUserRoles()}}, \cr
\code{\link[=importUserRoles]{importUserRoles()}}, \cr
\code{\link[=deleteUserRoles]{deleteUserRoles()}}
}
