#! /usr/bin/Rscript
library(SENDsanitizer)
SENDsanitizer::sanitize(path = '/work/xpt_files',where_to_save = '/work/fake_files')
