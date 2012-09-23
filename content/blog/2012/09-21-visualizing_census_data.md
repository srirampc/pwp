---
created_at: 2012-09-21
excerpt: A visualization of sex ratio data of districts in Tamil Nadu using R statistical language with maptools and ggpolt2.
kind: article
has_code: true
publish: true
tags: [visualization,R,statistics,tutorial,ggplot2]
title: "Visualizing Census Data"
---

Map based visualization and inforgraphics interest me. I especially like
the work of New york Times' visualization team. For example, look at the
[US census explorer][census-explorer], which maps income, housing and
education data based on surveys from 2005-2009 for every city and every
block for all the cities in the US. I really wish there was some
equivalent work done by the Indian Media.

I wanted to see if I can construct a map visualizing some Census data
that is of interest to us. I don't have the skills to make an
interactive map and hence, my goal was to build a static image depicting
specific census data. It took me a week to put togeather the following
image, which shows the change in sex ratio (measured as number of females
per thousand males) for the districts of Tamil Nadu based on the data from
1951, 1981 and 2011 census.

<a href="/assets/images/tn-sxr-chronos-blue.png">
<img style="margin: 0.5em auto 0.5em auto;"
  src="/assets/images/tn-sxr-chronos-blue-640-400.png"
  alt="Change in Sex Ratio from 1951 to 2011">
</a>

Two caveats: One, the districts of Tiruppur and Krishnagiri are missing,
because I didn't have the required geographical information. Two, the
intervals are defined such that approximately same number of data entries
fall within a given interval. In other words, if you count the total
number of regions coloured with the same shade, it should be
approximately same.

Still, there are a few interesting things to note in this
visualization. As a whole, we can see that the sex ratio in 1951 was
better than in 1981. Though 2011 is better, it is not as good as
1951. Note how the sex ratio increases for the Nilgiris district and
Ramanathapuram district goes in quite the opposite direction. I gladly
point out ('cause it is my home) that the southern districts of
Tirunelveli and Thoothukudi have fared better through out the years and
the sex ratio remains above 1015 during all the time! A more colourful
image of above is shown below:

<a href="/assets/images/tn-sxr-chronos.png">
<img style="margin: 0.5em auto 0.5em auto;"
  src="/assets/images/tn-sxr-chronos-640-400.png"
  alt="Change in Sex Ratio from 1951 to 2011">
</a>

The following is an account of how I made this map.
I started out with a search for the geographical data (i.e., latitude
and longitude) for the boundaries of India's administrative
regions. I find the lack of easily accessible geographical data for
India furstrating. For the United States, you get the information for every
county and every block from the [US census website][us-census]. India has
a [GIS website][ind-gis] and there is some mapping information
available at the [National Atlas][ind-gis-map] but they are in pdf
format, which are not amenable to build our own visualization using open
source tools.

I, then, tried to retreive the data from
[Open Street Map(OSM)][osm]. As awesome as Open Street Map is,
retrieving the district boundaries is not straight forward (as far as I
could understand) - especially for the costal districts. But if you are
doing visualization for any urban data, OSM is the place to go!
Finally, I found [gadm.org][gadm], where one can [download][gadm-dwn]
the geographical information for administrative regions for many
countries. The latitute and longitude coordinates are stored in a
standard [shapefile format][shape-file]. There are four different shape
files available for India : IND\_adm0.shp, IND\_adm1.shp, IND\_adm2.shp,
and IND\_adm3.shp. IND\_adm1.shp and IND\_adm2.shp has the information
of boundaries of the states and the districts in India respectively.

Now, I have to extract the longitude and latitude information only for
the districts of Tamil Nadu from the shape files. There are many
libraries available written in various programming languages to process
shape files. I choose to use 'R', the programming language for statistics,
because I liked the excellent spatial data graphics at the
[spatial analysis blog][spat-an] - most of them done using R.
After a bit of googling about the shape file format and R's maptools
library, I extracted the district information from IND\_adm2.shp as follows:
<pre><code class="language-r">
    library(maptools)
    # read the polygon shapes
    district_adm_shp = readShapePoly("IND_adm2.shp")
    # get the meta data of the polygons
    district_df = district_adm_shp@data
    # get the meta data of polygons of TN's districts
    tn_dist_df = data.frame(district_df[grep("Tamil",district_df$NAME_1),])
    # get polygon data of TN's districts
    polygon_list = list()
    for (istr in rownames(tn_dist_df)){
      i = as.numeric(istr) + 1
      tmp = district_adm_shp@polygons[i]
      polygon_list = c(polygon_list,tmp)
    }
    # construct a new shape file with only TN's districts
    dist_spatial = SpatialPolygons(polygon_list,1:30)
    dist_spatial_frame = SpatialPolygonsDataFrame(dist_spatial,data=tn_dist_df)
    writeSpatialShape(dist_spatial_frame,"tn_dist_state.shp")
    dist_df = readShapePoly("tn_dist_state.shp")
    plot(dist_df,add=TRUE) # should print a map of districts in TN
</code></pre>

I, then, added the sex ratio census data onto the meta data of the
shape file as follows. I downloaded the sex ratio data for the districts
of Tamil Nadu from the [India Census website][census-india]. From the
Excel sheet, I made a csv file (available [here][sxr-data]), because it
is easier to import csv data into R. The following commands add the
required meta data.
<pre><code class="language-r">
    # read the polygon shapes of TN's districts
    tn_dist = readShapePoly("tn_dist_state.shp")
    sxratio = read.csv("sex_ratio.csv")
    # add sex ratio information of TN's districts
    tn_dist@data$SXR_2011 = sxratio[1:30,"X2011"]
    tn_dist@data$SXR_1981 = sxratio[1:30,"X1981"]
    tn_dist@data$SXR_1951 = sxratio[1:30,"X1951"]
    # write to an output file
    writeSpatialShape(tn_dist,"tn_dist_sxr.shp")
</code></pre>
All the commands I used for data processing are given in the source file
[here][dp-src]. The final shape file for Tamil Nadu districts along with
the sex ratio info. collected at every Census from 1901 to 2011 is
[here][sxr-shp]. Note that the shape file is derived from [GADM][gadm]
data, which can be used only for non-commercial purposes.

After extracting the necessary data, I used [ggolot2][ggp] library in R
to plot the map and fill colours according to the sex ratio data. Since
ggplot2 is a powerful plotting system with many features, I haven't
explained it step-by-step. You can see commands for plotting in the
source code [here][ggp-src].

I hope to do more map based visualizations in the future.


[census-explorer]: http://projects.nytimes.com/census/2010/explorer
[shape-file]: http://en.wikipedia.org/wiki/Shapefile
[osm]: http://openstreetmap.org
[gadm]: http://gadm.org
[gadm-dwn]: http://gadm.org/country
[spat-an]: http://spatialanalysis.co.uk/
[sxr-data]: /assets/src/sex_ratio.csv
[census-india]: http://www.censusindia.gov.in/2011-prov-results/prov_data_products_tamilnadu.html
[ggp]: http://ggplot2.org/
[sxr-shp]: /assets/src/tn_dist_sxr.zip
[dp-src]: /assets/src/data_process.R
[ggp-src]: /assets/src/data_viz.R
[us-census]: http://www.census.gov/geo/www/tiger/
[ind-gis]: http://gis.nic.in/
[ind-gis-map]: http://atlas.gisserver.nic.in/
