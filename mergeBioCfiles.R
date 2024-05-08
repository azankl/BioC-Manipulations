#This script reads xml files in BioC format and combines them into one document

library(xml2)
library(here)
library(tidyverse)

# Get a list of XML files
files <- list.files(here("BioC_files"), pattern = "*.xml")

# Read each XML file into a list of XML documents
xml_docs <- lapply(here("BioC_files",files), read_xml)

# Create a new XML document
new_doc <- xml_new_root("collection") 
xml_add_child(new_doc, "source")
xml_add_child(new_doc, "date")
xml_add_child(new_doc, "key")

#write some text into the metadata nodes
#https://stackoverflow.com/questions/59299200/how-to-edit-a-value-in-xml-in-r-xml
to_mod <-xml_find_first(new_doc, "//source")
xml_text(to_mod) <- "future Github URL for Corpus goes here"
to_mod <-xml_find_first(new_doc, "//date")
xml_text(to_mod) <- "future release date of Corpus goes here"
to_mod <-xml_find_first(new_doc, "//key")
xml_text(to_mod) <- "future BioC key file of Corpus goes here"

# Add the <document> node of each XML file as a child to the new XML document
for (doc in xml_docs) {
  xml_add_child(new_doc, xml_child(doc, search = "document"))
 }
# same using purrr::map
# xml_docs %>% 
#   purrr::map(~ xml_add_child(new_doc, .x))

# Write the new XML document to a file
write_xml(new_doc, here("corpus.xml"))
