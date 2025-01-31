## Author: Carlos Navarro
## CIAT 2022
## Organize WorldClim files into Alliance DFS system

library(stringr)

bs_dir <- "V:/GLOBAL/climate/Agroclimas/wc2.1_30s" 
ot_dir <- "V:/GLOBAL/climate/Agroclimas/data/ipcc_6ar_wcl_downscaled_fixed"

res_dc <- c("2.5m"="2_5min", "5m"="5min", "10m"="10min", "30s"="30s")
var_dc <- c("bioc"="bio", "prec"="prec", "tmax"="tmax", "tmin"="tmin")
per_dc <- c("2021-2040"="2030s", "2041-2060"="2050s", "2061-2080"="2070s", "2081-2100"="2090s")
scn_dc <- c("ssp126"="ssp_126", "ssp245"="ssp_245", "ssp370"="ssp_370", "ssp585"="ssp_585")

fl_list <- list.files(paste0(bs_dir), full.names = TRUE, recursive = FALSE)

for (fl in sort(fl_list)){
  
  res <- str_split(basename(fl), "_")[[1]][2] 
  var <- str_split(basename(fl), "_")[[1]][3] 
  gcm <- str_split(basename(fl), "_")[[1]][4]
  scn <- str_split(basename(fl), "_")[[1]][5]
  per <-  str_replace(str_replace(str_split(basename(fl), "_")[[1]][6], ".tif", ""), "f", "") 
  
  scn_mod <- str_replace(scn, "_", "")
  gcm_mod <- tolower(str_replace_all(gcm, "-", "_"))
  
  ot_dir_fl <- paste0(ot_dir, "/", scn_dc[scn], "/", per_dc[per], "/", gcm_mod, "/", res_dc[res])
  out_fl <- paste0(gcm_mod, "_", scn, "_", per_dc[per], "_", var_dc[var], "_", str_replace(res, "2.", "2_"), "_no_tile_tif.tif")
  
  if (!file.exists(ot_dir_fl)) {dir.create(ot_dir_fl, recursive=T)}
  
  file.rename(from = fl,  to = paste0(ot_dir_fl, "/", out_fl))
  
} 


# # Fix
# 
# fl_list <- list.files(paste0(ot_dir), full.names = TRUE, recursive = TRUE)
# for (fl in fl_list){
#   
#   newpath <- str_replace_all(dirname(fl), "-", "_") 
#   if (!file.exists(newpath)) {dir.create(newpath, recursive=T)}
#   
#   file.rename(from = fl,  to = str_replace_all(fl, "-", "_"))
#   cat(paste0(str_replace_all(fl, "-", "_"), "\n"))
# 
# }
