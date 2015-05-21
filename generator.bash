# file name
echo "Please enter the font name: "
read i

# Fontforge script to generate ttf and svg
fontforge -script ttf-svg.pe $i

# Clean svg with Scour
python scour/scour.py -i ${i::-4}.svg -o tmp.svg
# Remove unclean svg
rm ${i::-4}.svg
# Improve ttf hinting
ttfautohint -v -f latn ${i::-4}.ttf ${i::-4}.ttf

# generate woff and eot
sfnt2woff $i
mkeot $i -> ${i::-4}.eot

# Create new folder for output
mkdir ${i::-4}-webfonts
# copy original file and generated files
cp $i ${i::-4}-webfonts/$i
mv ${i::-4}.ttf ${i::-4}-webfonts/${i::-4}-webfont.ttf
mv ${i::-4}.woff ${i::-4}-webfonts/${i::-4}-webfont.woff
mv tmp.svg ${i::-4}-webfonts/${i::-4}-webfont.svg
mv ${i::-4}.eot ${i::-4}-webfonts/${i::-4}-webfont.eot

echo "TTF, OTF, EOT and WOFF was generated, see $i-webfonts directory :)"
