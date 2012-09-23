library(maptools)
library(rgeos)
library(RColorBrewer)
library(classInt)
library(ggplot2)

# Disclaimer : This (most) probably is not an efficient way to do this.
# But, this is the only way I know
# Author : {github.com|bitbucket.org|twitter.com}/srirampc
# License : CC-BY-SA
# http://creativecommons.org/licenses/by-sa/3.0/
# Note : License is only for this program, not for the data.
# Data is not mine!

# District shape file with Sex Ration data
tn_dist <- readShapePoly("tn_dist_sxr.shp")

# Simple Plot sex ratio for year 2011
colours <- brewer.pal(8,"Blues")
brks <- classIntervals(tn_dist$SXR_2011,n=8,style="quantile")
plot(brks,colours)
plot(tn_dist,col=colours[findInterval(tn_dist$SXR_2011,
               brks$brks,all.inside=TRUE)],axes=F)
legend(x=74.9,y=9.55,  legend=leglabs(brks$brks), fill=colours, bty="n")

# Plot sex ratio with three years 1951,1981 and 2011 using ggplot2
# Setup data
# Get polygon data using fortify :
#   - fortify generates latitute and longitude as columns in a data frame
y <- fortify(tn_dist)
#
tnsxr2011 <- y
tnsxr1981 <- y
tnsxr1951 <- y
tnsxr2011$year <- 2011
tnsxr1981$year <- 1981
tnsxr1951$year <- 1951
brks <- classIntervals(c(tn_dist$SXR_2011,tn_dist$SXR_1981,tn_dist$SXR_1951),
                       n=8,style="quantile")
in2011 <- findInterval(tn_dist$SXR_2011,brks$brks,all.inside=TRUE)
in1981 <- findInterval(tn_dist$SXR_1981,brks$brks,all.inside=TRUE)
in1951 <- findInterval(tn_dist$SXR_1951,brks$brks,all.inside=TRUE)
tnsxr2011$sxr <- 0
tnsxr1981$sxr <- 0
tnsxr1951$sxr <- 0
for(i in 1:length(in2011)){
  tnsxr2011[tnsxr2011$id == (i-1),]$sxr <- in2011[i]
}
for(i in 1:length(in1981)){
  tnsxr1981[tnsxr1981$id == (i-1),]$sxr <- in1981[i]
}
for(i in 1:length(in1951)){
  tnsxr1951[tnsxr1951$id == (i-1),]$sxr <- in1951[i]
}
total <- rbind(tnsxr1951,tnsxr1981,tnsxr2011)

# A ggplot2 example - To test if everything works
p <- ggplot(data = total)
p <- p + geom_polygon(data=total, aes(x=long, y=lat,
                        group=group, fill = factor(sxr)))
p + facet_grid(. ~ year) + scale_fill_brewer()

# Setting labels
v <- c()
for( i in 1:length(brks$brks)){
    sval = str_c(floor(brks$brks[i]))
    if(i != length(brks$brks)) {
      nval = str_c(floor(brks$brks[i+1]))
      v <- c(v, paste(sval, " - ",nval))
    }
  }
# Finally generate the plot!
p <- ggplot(data=total)
p <- p + geom_polygon(aes(x=long, y=lat, group=group,fill=factor(sxr)),
                      colour="grey30")
p + scale_fill_brewer(name="Sex Ratio",palette="Blues",labels=v) + facet_grid(. ~ year)
# Different colours
p + scale_fill_brewer(name="Sex Ratio",palette="Spectral",labels=v) + facet_grid(. ~ year)

# Possible palettes, if you are interested in more
RColorBrewer::display.brewer.all(n=8, exact.n=FALSE)

# experimental
for(i in 1:length(tn_dist$SXR_2011)){
  tnsxr2011[tnsxr2011$id == (i-1),]$sxr <- tn_dist$SXR_2011[i]
}
for(i in 1:length(tn_dist$SXR_1981)){
  tnsxr1981[tnsxr1981$id == (i-1),]$sxr <- tn_dist$SXR_1981[i]
}
for(i in 1:length(tn_dist$SXR_1951)){
  tnsxr1951[tnsxr1951$id == (i-1),]$sxr <- tn_dist$SXR_1951[i]
}
total2 <- rbind(tnsxr1951,tnsxr1981,tnsxr2011)
