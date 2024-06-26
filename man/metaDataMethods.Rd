% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/docsMetaDataMethods.R, R/exportMetaData.R,
%   R/importMetaData.R
\name{metaDataMethods}
\alias{metaDataMethods}
\alias{metaDataMethodsArgs}
\alias{exportMetaData}
\alias{importMetaData}
\alias{exportMetaData.redcapApiConnection}
\alias{importMetaData.redcapApiConnection}
\title{Export and Import the Project Meta Data (Data Dictionary)}
\usage{
exportMetaData(rcon, ...)

importMetaData(rcon, data, ...)

\method{exportMetaData}{redcapApiConnection}(
  rcon,
  fields = character(0),
  forms = character(0),
  ...,
  error_handling = getOption("redcap_error_handling"),
  config = list(),
  api_param = list()
)

\method{importMetaData}{redcapApiConnection}(
  rcon,
  data,
  ...,
  field_types = REDCAP_METADATA_FIELDTYPE,
  validation_types = REDCAP_METADATA_VALIDATION_TYPE,
  error_handling = getOption("redcap_error_handling"),
  config = list(),
  api_param = list()
)
}
\arguments{
\item{rcon}{A \code{redcapConnection} object.}

\item{fields}{\code{character} vector of field names for which the metadata is to
be retrieved.}

\item{forms}{\code{character} vector of forms for which the metadata is to be
retrieved. If a form name is given, all of the fields on that form
will be returned, regardless of whether it is included in \code{fields} or
not.  Form names should match those in the second column of the data
dictionary, and not the display names shown on the web interface.}

\item{data}{\code{data.frame} with the Meta Data to import.}

\item{...}{Arguments to pass to other methods}

\item{field_types}{\code{character} giving the acceptable field types
when validating the \code{field_type} column. This}

\item{validation_types}{\code{character} giving the acceptable values
for the \code{text_validation_or_show_slider_number} column.}

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
\code{exportMetaData} returns a data frame. Not all 18 (or more) columns are
documented here, but the most commonly used within \code{redcapAPI} are
(these may appear in a different order in the data frame):\tabular{ll}{
    \tab  \cr
   \code{field_name} \tab The name of a field in the project. \cr
   \code{filed_label} \tab The human-readable form of the field name. \cr
   \code{form_name} \tab The name of the form on which the field is found. \cr
   \code{field_type} \tab One of two fields used to determine how a field is transformed into an R object. \cr
   \code{select_choices_or_calculations} \tab The second field used to determine how a field is translated into an R object. \cr
   \code{text_validation_type_or_show_slider_number} \tab Describes how fields are validated. For slider fields, it gives the limits and center point to display. \cr
   \code{field_annotation} \tab Contains annotations such as units of measures. Also contains action tags. \cr
}


\code{importMetaData} invisibly returns the number of fields that were imported.
}
\description{
These methods provide the user access to a REDCap project's
data dictionary. The data dictionary may be exported or altered via
the import.
}
\details{
When importing meta data, the following conditions apply:

Field names may start with a letter, have any number of letters,
numbers, or underscores, and end in either a letter or a number. All
letters must be lowercase (the function will coerce them to lower before
checking for duplicate field names).

Form names may start with a letter, have any number of letters,
numbers, or underscores, and end in either a letter or a number. All
letters must be lowercase (the function will coerce them to lower before
checking for duplicate field names).

Field types may be one of \code{REDCAP_METADATA_FIELDTYPE}. In the event that a
new field type is added to REDCap and \code{redcapAPI} is not yet updated,
the user may add additional values via \code{c(REDCAP_METADATA_FIELDTYPE, "new_type")}.

Validation types may be one of \code{REDCAP_METADATA_VALIDATION_TYPE} or
\code{NA}. As with field types, additional values can be appended if
necessary. Only fields that have a field type of "text" or "slider"
should have a validation type. "slider" fields should be either \code{NA}
(do not display the selected number) or \code{"number"}.

For multiple choice fields, the selection choices take the format of
\code{"code1, label1 | ... | coden, labeln"}. For slider fields, the
format is \code{"left_value | mid_value | right_value"}. Any of those
values may be an empty character, but the two pipes are required, nonetheless.

For calculated fields, the values in \code{"select_choices_or_calculations"}
are currently unvalidated.

All of the values between brackets in the branching logic must be either a
field name or an existing unique event name (such as \code{"event_1_arm_1"})
}
\section{Functions}{
\itemize{
\item \code{exportMetaData()}: Export the Meta Data (Data Dictionary) of a REDCap Project

\item \code{importMetaData()}: Import New Meta Data (Data Dictionary) Definitions

}}
\examples{
\dontrun{
unlockREDCap(connections = c(rcon = "project_alias"), 
             url = "your_redcap_url", 
             keyring = "API_KEYs", 
             envir = globalenv())

# Export the MetaData from REDCap
exportMetaData(rcon)

# Export MetaData for select fields only (returns two rows)
exportMetaData(rcon, 
               fields = c("dropdown_test", "radio_test"))

# Export MetaData for select forms
exportMetaData(rcon, 
               forms = c("first_form", "second_form"))
               
# MetaData my be exported for a combination of fields and forms
exportMetaData(rcon, 
               fields = c("dropdown_test", "radio_test"), 
               forms = c("first_form", "second_form"))
               
# Alter and import new MetaData (change the record ID label)
Meta <- exportMetaData(rcon)

Meta$field_label[1] <- "A better description of the Record ID"
importMetaData(rcon, 
               data = Meta)
}
}
\seealso{
\code{\link[=exportFieldNames]{exportFieldNames()}},\cr
\code{\link[=exportInstruments]{exportInstruments()}},\cr
\code{\link[=exportMappings]{exportMappings()}},\cr
\code{\link[=importMappings]{importMappings()}}, \cr
\code{\link[=exportPdf]{exportPdf()}}
}
