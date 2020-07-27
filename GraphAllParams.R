library(glmtools)
library(ncdf4)

colors = c('red','blue','green','black','yellow','cyan','orange','darkgreen','violet','magenta')
for (ii in seq(1,5)){
  if (ii ==1){
    system2('/home/aryan/Documents/Testing/GLM/glm')
    system('docker run -it -d -v /home/aryan/Documents/Testing:/GLM/Testing aruadhlakha/glm-aed2:latest /bin/bash')
    dockerps <- system('docker ps',intern = TRUE)
    dockerid <- strsplit(dockerps, split = "/t")
    dockerid <- dockerid[[2]][1]
    dockerid <- gsub( " .*$", "", dockerid )
  } else {
    #system2('/Users/robertladwig/Documents/AquaticEcoDynamics_stochast/GLM/glm')
    system(paste('docker exec -t',dockerid,'/bin/bash -c \"cd Testing; /GLM/glm\"'))
  }
  
  # system2('/Users/robertladwig/Documents/AquaticEcoDynamics_gfort/GLM/glm')
  out <- 'output/output.nc'
  ncin <- nc_open('output/output.nc')
  sim_time <- ncvar_get(ncin, "time")
  sim_ns <- ncvar_get(ncin, "NS")
  sim_z <- ncvar_get(ncin, "z")
  sim_temp <- ncvar_get(ncin, "temp")
  sim_cyano <- ncvar_get(ncin, "PHY_cyano")
  sim_diatom <- ncvar_get(ncin, "PHY_diatom")
  ref_time <- ncin$dim$time$units
  ref_time <- gsub('hours since ', '', ref_time)
  if (ii==1){
    plot(sim_time,sim_cyano[10,], col = colors[ii])
    points(sim_time,sim_diatom[10,], col = colors[ii])
  }else{
    points(sim_time,sim_cyano[10,], col = colors[ii])
    points(sim_time,sim_diatom[10,], col = colors[ii])
  }
  nc_close(ncin)
}

plot_var('output/output.nc', var_name = 'PHY_cyano',reference = 'surface')
plot_var('output/output.nc', var_name = 'PHY_diatom', reference = 'surface')

system('docker kill $(docker ps -q)')
system('docker rm $(docker ps -a -q)')