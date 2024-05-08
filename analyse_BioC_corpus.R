#This script analyses the BioC corpus.xml file
#Goal is to count the different types of annotation per article

library(xml2)
library(here)
library(tidyverse)

#Load the BioC corpus.xml file
