library(maptools)
library(rgeos)

# This R script lists the sequence of commands required to
# generate the shape files containing the sex ratio data for the
# districts of the state of Tamil Nadu, India

# Disclaimer : This is (most) probably not an efficient way to extract
# this data.
# But, this is the only way I know.
# Author : {github.com|bitbucket.org|twitter.com}/srirampc
# License : CC-BY-SA
# http://creativecommons.org/licenses/by-sa/3.0/
# Note : License is only for this program, not for the data.
# Data is not mine!

# Extract Tamil Nadu polygon from IND_adm1.shp
#  IND_adm1.shp is from gadm.org
stp <- readShapePoly("IND_adm1.shp")
sdf <- stp@data
df2 <- data.frame(sdf[grep("Tamil",sdf$NAME_1),])
tnp <- stp@polygons[31] #index for tamil nadu
stnp <- SpatialPolygons(tnp,1:1)
stnp_df <- SpatialPolygonsDataFrame(stnp,data=df2)
writeSpatialShape(stnp_df,"tn_state.shp")

tn_df <- readShapePoly("tn_state.shp")
plot(tn_df) # should print a map of TN

# Extract Tamil Nadu district polygons from IND_adm2.shp
#  IND_adm2.shp is from gadm.org
district_adm_shp <- readShapePoly("IND_adm2.shp")
district_df <- district_adm_shp@data
tn_dist_df <- data.frame(district_df[grep("Tamil",district_df$NAME_1),])
polygon_list <- list()
for (istr in rownames(tn_dist_df)){
  i <- as.numeric(istr) + 1
  tmp <- district_adm_shp@polygons[i]
  polygon_list <- c(polygon_list,tmp)
}
dist_spatial <- SpatialPolygons(polygon_list,1:30)
dist_spatial_frame <- SpatialPolygonsDataFrame(dist_spatial,data=tn_dist_df)
writeSpatialShape(dist_spatial_frame,"tn_dist_state.shp")
dist_df <- readShapePoly("tn_dist_state.shp")
plot(dist_df,add=TRUE) # should print a map of districts in TN

# Update sex ratio data :
#  - Data obtained from the India Census website
# http://www.censusindia.gov.in/2011-prov-results/prov_data_products_tamilnadu.html
tn_state <- readShapePoly("tn_state.shp")
tn_dist <- readShapePoly("tn_dist_state.shp")
sxratio <- read.csv("sex_ratio.csv")
tn_dist@data$SXR_2011 <- sxratio[1:30,"X2011"]
tn_dist@data$SXR_2001 <- sxratio[1:30,"X2001"]
tn_dist@data$SXR_1991 <- sxratio[1:30,"X1991"]
tn_dist@data$SXR_1981 <- sxratio[1:30,"X1981"]
tn_dist@data$SXR_1971 <- sxratio[1:30,"X1971"]
tn_dist@data$SXR_1961 <- sxratio[1:30,"X1961"]
tn_dist@data$SXR_1951 <- sxratio[1:30,"X1951"]
tn_dist@data$SXR_1941 <- sxratio[1:30,"X1941"]
tn_dist@data$SXR_1931 <- sxratio[1:30,"X1931"]
tn_dist@data$SXR_1921 <- sxratio[1:30,"X1921"]
tn_dist@data$SXR_1911 <- sxratio[1:30,"X1911"]
tn_dist@data$SXR_1901 <- sxratio[1:30,"X1901"]
writeSpatialShape(tn_dist,"tn_dist_sxr.shp")
