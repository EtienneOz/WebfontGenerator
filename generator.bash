# OTF

# get font(s)
FILES=input/*.otf
for font in $FILES
do
  # Fontforge script to generate ttf and svg
  fontforge -script ttf-svg.pe $font

  # Clean svg with Scour
  python scour/scour.py -i ${font::-4}.svg -o tmp.svg
  # Remove unclean svg
  rm ${font::-4}.svg
  # Improve ttf hinting
  ttfautohint -v -f latn ${font::-4}.ttf ${font::-4}.ttf

  # generate woff and eot
  sfnt2woff $font
  mkeot $font -> ${font::-4}.eot

  # Create new folder for output
  mkdir ${font::-4}-webfonts
  # Get the filename without path
  filename=$(basename "$font")
  # copy original file and move generated files
  cp $font ${font::-4}-webfonts/${filename::-4}-webfont.otf
  mv ${font::-4}.ttf ${font::-4}-webfonts/${filename::-4}-webfont.ttf
  mv ${font::-4}.woff ${font::-4}-webfonts/${filename::-4}-webfont.woff
  mv tmp.svg ${font::-4}-webfonts/${filename::-4}-webfont.svg
  mv ${font::-4}.eot ${font::-4}-webfonts/${filename::-4}-webfont.eot
  # move everything in output directory
  mv ${font::-4}-webfonts/ output/${filename::-4}-webfonts/

done


# TTF

#get font(s)
FILES=input/*.ttf
for font in $FILES
do
  # Fontforge script to generate ttf and svg
  fontforge -script otf-svg.pe $font

  # Clean svg with Scour
  python scour/scour.py -i ${font::-4}.svg -o tmp.svg
  # Remove unclean svg
  rm ${font::-4}.svg
  # Improve ttf hinting
  ttfautohint -v -f latn ${font::-4}.ttf ${font::-4}.ttf

  # generate woff and eot
  sfnt2woff $font
  mkeot $font -> ${font::-4}.eot

  # Create new folder for output
  mkdir ${font::-4}-webfonts
  # Get the filename without path
  filename=$(basename "$font")
  # copy original file and move generated files
  cp $font ${font::-4}-webfonts/${filename::-4}-webfont.ttf
  mv ${font::-4}.otf ${font::-4}-webfonts/${filename::-4}-webfont.otf
  mv ${font::-4}.woff ${font::-4}-webfonts/${filename::-4}-webfont.woff
  mv tmp.svg ${font::-4}-webfonts/${filename::-4}-webfont.svg
  mv ${font::-4}.eot ${font::-4}-webfonts/${filename::-4}-webfont.eot
  # move everything in output directory
  mv ${font::-4}-webfonts/ output/${filename::-4}-webfonts/

done



echo "TTF, OTF, EOT and WOFF were generated, see output directory :)"
