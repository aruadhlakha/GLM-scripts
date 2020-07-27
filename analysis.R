library(glmtools)
library(ncdf4)
aed_nml <- read_nml("/home/aryan/Documents/dockerTest/aed2/aed2.nml")
out_file <- 'output/output.nc'
ncin <- nc_open('output/output.nc')
plot_var('output/output.nc', var_name = 'PHY_cyano',reference = 'surface')
plot_var('output/output.nc', var_name = 'PHS_frp',reference = 'surface')
plot_var('output/output.nc', var_name = 'NIT_nit',reference = 'surface')
plot_var('output/output.nc', var_name = 'PHY_diatom', reference = 'surface')
phyto_list <- get_nml_value(aed_nml,arg_name = 'aed2_phytoplankton::dbase')
path_phyto <- phyto_list
phyto_nml <- read_nml(path_phyto)
phyto_nam <- get_nml_value(phyto_nml,arg_name = 'pd%p_name')
names <- unlist(strsplit(phyto_nam, ","))
lim_attributes <- c('fI', 'fNit', 'fPho', 'fSil', 'fT', 'fSal')
plist <- list()
pindex <- 1
for (ii in seq_len(length(names))){
  for (jj in seq_len(length(lim_attributes))){
    p1 <- plot_var('output/output.nc', var_name = paste0('PHY_',names[ii],'_',
                                                         lim_attributes[jj]),
                   legend.title = paste(names[ii], lim_attributes[jj]))
    plist[[pindex]] <- p1
    pindex <- pindex + 1
  }
}
p_cyano <- plist[[1]] /plist[[2]] / plist[[3]] / plist[[4]] / plist[[5]] / plist[[6]] 
p_diatom <- plist[[7]] / plist[[8]] / plist[[9]] / plist[[10]] / plist[[11]] / plist[[12]] 
p_cyano
p_diatom