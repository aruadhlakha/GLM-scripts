library(glmtools)
library(ncdf4)
colors = c('red','blue','green','black','yellow','cyan','orange','darkgreen','violet','magenta')
for (ii in seq(1,2)){
  #system2('/home/aryan/Documents/Testing/GLM/glm')
  out <- 'output/output.nc'
  ncin <- nc_open('output/output.nc')
  sim_time <- ncvar_get(ncin, "time")
  sim_ns <- ncvar_get(ncin, "NS")
  sim_z <- ncvar_get(ncin, "z")
  sim_temp <- ncvar_get(ncin, "temp")
  sim_cyano <- ncvar_get(ncin, "PHY_cyano")
  ref_time <- ncin$dim$time$units
  ref_time <- gsub('hours since ', '', ref_time)
  if (ii==1){
    plot(sim_time,sim_cyano[10,], col = colors[ii])
  }else{
       points(sim_time,sim_cyano[10,], col = colors[ii])
  }
  nc_close(ncin)
}
