#! /bin/bash

# This script can be adapted to make a pretty map of your choosing.
# Ask if you're having trouble making your map do as you prefer!
# JCEI 03/07/2017
# JCEI 25/07/2019


# Set output file
filename="geoloc_map.ps"
efnm=`echo $filename | sed 's/.ps/.eps/g'`
pfnm=`echo $filename | sed 's/.ps/.pdf/g'`

# Plotting prep
gmt gmtset FONT_ANNOT_PRIMARY 8p,Helvetica
gmt gmtset FONT_TITLE 12p,Helvetica
gmt gmtset FONT_LABEL 8p,Helvetica
gmt gmtset PROJ_LENGTH_UNIT cm
gmt gmtset PS_PAGE_ORIENTATION portrait
gmt gmtset PS_MEDIA letter
o="-K -V -O"

# Variables for figure width, caption location, and example of bash arithmetic
figw=8
half=$((figw/2))

# DEFINE PROJECTION, global or otherwise.
#proj=" -Rg -JG3.5/50/12c"
proj=" -Rg -JR0/12c"
#proj=" -R-10/20/40/60 -JT3.5/50/${figw}c"




# Colour palette selection. -Z flag would make continuous. Games can be
# played to make the colour palette as you prefer.
# See http://soliton.vm.bytemark.co.uk/pub/cpt-city/ for *many* palettes.
gmt makecpt -Ccool -T7/9/0.25 -Z | awk '{if ($1 >= 0) print $0}' > chil.cpt
#gmt makecpt -Cwysiwyg -T0/4/1  > chil.cpt

# Write PS header - so no care is needed for the -K or -O flags later (historical)
echo 0 0 | gmt psxy -R1/2/1/2 -JX4.25/10 -Sp -K -Y15 > $filename

gmt psbasemap $o $proj -Bg45   >> $filename

# The -A flag determines complexity of small features
gmt pscoast $proj  -Bx60g60 -By30g30 -N1/0.25p,-  -W0.25p -Glightgreen -Slightblue -W0.25p $o -A0/0/1 >> $filename
#gmt pscoast $proj -Bx60g60 -By30g30 -I1/1p,pink -N1/0.25p,-   -I2/0.25p,pink -W0.25p,orange -Glightgreen -Slightblue  $o >> $filename


# Use awk to extract the columns we want from the data file
awk '{print $1, $2, $3}' $1 | gmt psxy $proj  -Cchil.cpt -W1p -Sc0.3 -: $o >> $filename
awk '{print $1, $2, $3}' $2 | gmt psxy $proj  -Cchil.cpt -W1p -Sc0.3 -: $o >> $filename

# Label something - an ocean
# Font information is in the -F flag.
# echo "50 5.  CM Eur" | gmt pstext $proj -N $o -F+f9,0,black+j -:  >> $filename

# Plot scale + key
# Notice that there is a warning output on screen because I used old syntax here
gmt psscale -Cchil.cpt -D6c/-1.5c/4c/0.4ch -Np -Ba0.5f2:"Magnitude": $o >>$filename


# Finish up  (historical)
echo 0 0 | gmt psxy -R1/2/1/2 -JX1/1 -Sp -O >> $filename

echo " made $filename"

# Convert the output file to other formats: eps and pdf. png also may be helpful. 
ps2eps -f $filename 
convert -density 300 $efnm $pfnm

gv $filename &
