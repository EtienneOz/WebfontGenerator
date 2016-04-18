#!/bin/bash

echo "----------------"
echo "webfontgenerator"
echo "----------------"

# get familles folders
familles=input/*

for famille in $familles;
    do
		
	# get famille name without path 
	famillename=$(basename "$famille")
	echo $famillename

	# create new famille folder for output
	mkdir output/$famillename

	# extensions .otf .ttf
	ext1=(`find $famille -maxdepth 1 -name "*.otf"`)
	ext2=(`find $famille -maxdepth 1 -name "*.ttf"`)

	# get font(s) ---> OTF
	if [ ${#ext1[@]} -gt 0 ];
	    then
		fonts=$famille/*.otf
		for font in $fonts
		do
		    # get font path without extension
		    fontpath=${font::-4}

		    # get filename without path and extension
		    fontname=$(basename "${font::-4}")
		    echo $fontname

		    # Fontforge script to generate ttf and svg
		    fontforge -script ttf-svg.pe $font

		    # clean svg with Scour
		    python scour/scour.py -i $fontpath.svg -o tmp.svg
		    
		    # remove unclean svg
		    rm $fontpath.svg
		    
		    # improve ttf hinting
		    ttfautohint -v -f latn $fontpath.ttf $fontpath.ttf

		    # generate woff and eot
		    sfnt2woff $font
		    mkeot $font -> $fontpath.eot

		    # create new font folder for output
		    mkdir output/$famillename/$fontname
      
		    # copy original file and move generated files
		    cp $font output/$famillename/$fontname/$fontname.otf
		    mv $fontpath.ttf output/$famillename/$fontname/$fontname.ttf
		    mv $fontpath.woff output/$famillename/$fontname/$fontname.woff
		    mv tmp.svg output/$famillename/$fontname/$fontname.svg
		    mv $fontpath.eot output/$famillename/$fontname/$fontname.eot
      
		    # create css for font
		    echo "
/*$fontname*/
@font-face {
    font-family: '$fontname';
    src: url('$fontname.eot'); /* IE 9 Compatibility Mode */
    src: url('$fontname.eot?#iefix') format('embedded-opentype'), /* IE < 9 */
         url('$fontname.woff') format('woff'), /* Firefox >= 3.6, any other modern browser */
         url('$fontname.ttf') format('truetype'), /* Safari, Android, iOS */
         url('$fontname.svg#$fontname') format('svg'); /* Chrome < 4, Legacy iOS */
    }" > output/$famillename/$fontname/$fontname-stylesheet.css 

		    # create css for famille
		    echo "
/*$fontname*/
@font-face {
    font-family: '$fontname';
    src: url('$fontname/$fontname.eot'); /* IE 9 Compatibility Mode */
    src: url('$fontname/$fontname.eot?#iefix') format('embedded-opentype'), /* IE < 9 */
         url('$fontname/$fontname.woff') format('woff'), /* Firefox >= 3.6, any other modern browser */
         url('$fontname/$fontname.ttf') format('truetype'), /* Safari, Android, iOS */
         url('$fontname/$fontname.svg#$fontname') format('svg'); /* Chrome < 4, Legacy iOS */
    }" >> output/$famillename/$famillename-stylesheet.css 

		    # create css for output
		    echo "
/*$fontname*/
@font-face {
    font-family: '$fontname';
    src: url('$famillename/$fontname/$fontname.eot'); /* IE 9 Compatibility Mode */
    src: url('$famillename/$fontname/$fontname.eot?#iefix') format('embedded-opentype'), /* IE < 9 */
	 url('$famillename/$fontname/$fontname.woff') format('woff'), /* Firefox >= 3.6, any other modern browser */
	 url('$famillename/$fontname/$fontname.ttf') format('truetype'), /* Safari, Android, iOS */
	 url('$famillename/$fontname/$fontname.svg#$fontname') format('svg'); /* Chrome < 4, Legacy iOS */
    }" >> output/output-stylesheet.css 
		    
		done
    
		tput setaf 2
		echo TTF, EOT and WOFF were generated, see output directory :\)
		tput sgr0

        # get font(s) ---> TTF
	elif [ ${#ext2[@]} -gt 0 ];
	    then
		fonts=$famille/*.ttf
		for font in $fonts
		do
		    # get font path without extension
		    fontpath=${font::-4}

		    # get filename without path and extension
		    fontname=$(basename "${font::-4}")
		    echo $fontname

		    # Fontforge script to generate ttf and svg
		    fontforge -script otf-svg.pe $font

		    # clean svg with Scour
		    python scour/scour.py -i $fontpath.svg -o tmp.svg
		    
		    # remove unclean svg
		    rm $fontpath.svg
		    
		    # improve ttf hinting
		    ttfautohint -v -f latn $fontpath.ttf $fontpath.ttf

		    # generate woff and eot
		    sfnt2woff $font
		    mkeot $font -> $fontpath.eot

		    # create new font folder for output
		    mkdir output/$famillename/$fontname
      
		    # copy original file and move generated files
		    cp $font output/$famillename/$fontname/$fontname.ttf
		    mv $fontpath.ttf output/$famillename/$fontname/$fontname.otf
		    mv $fontpath.woff output/$famillename/$fontname/$fontname.woff
		    mv tmp.svg output/$famillename/$fontname/$fontname.svg
		    mv $fontpath.eot output/$famillename/$fontname/$fontname.eot
      
		    # create css for font
		    echo "
/*$fontname*/
@font-face {
    font-family: '$fontname';
    src: url('$fontname.eot'); /* IE 9 Compatibility Mode */
    src: url('$fontname.eot?#iefix') format('embedded-opentype'), /* IE < 9 */
         url('$fontname.woff') format('woff'), /* Firefox >= 3.6, any other modern browser */
         url('$fontname.ttf') format('truetype'), /* Safari, Android, iOS */
         url('$fontname.svg#$fontname') format('svg'); /* Chrome < 4, Legacy iOS */
    }" > output/$famillename/$fontname/$fontname-stylesheet.css 

		    # create css for famille
		    echo "
/*$fontname*/
@font-face {
    font-family: '$fontname';
    src: url('$fontname/$fontname.eot'); /* IE 9 Compatibility Mode */
    src: url('$fontname/$fontname.eot?#iefix') format('embedded-opentype'), /* IE < 9 */
         url('$fontname/$fontname.woff') format('woff'), /* Firefox >= 3.6, any other modern browser */
         url('$fontname/$fontname.ttf') format('truetype'), /* Safari, Android, iOS */
         url('$fontname/$fontname.svg#$fontname') format('svg'); /* Chrome < 4, Legacy iOS */
    }" >> output/$famillename/$famillename-stylesheet.css 
	
		    # create css for output
		    echo "
/*$fontname*/
@font-face {
   font-family: '$fontname';
   src: url('$famillename/$fontname/$fontname.eot'); /* IE 9 Compatibility Mode */
   src: url('$famillename/$fontname/$fontname.eot?#iefix') format('embedded-opentype'), /* IE < 9 */
        url('$famillename/$fontname/$fontname.woff') format('woff'), /* Firefox >= 3.6, any other modern browser */
        url('$famillename/$fontname/$fontname.ttf') format('truetype'), /* Safari, Android, iOS */
        url('$famillename/$fontname/$fontname.svg#$fontname') format('svg'); /* Chrome < 4, Legacy iOS */
   }" >> output/output-stylesheet.css 

		done
	
	# wrong extension
	else
	    tput setaf 1
	      echo Wrong file extension, you can only use ttf and otf as input.
	    tput sgr0
	fi
    done
