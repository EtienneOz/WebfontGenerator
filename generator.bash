echo "Please enter the font name: "
read i
fontforge -script ttf-svg.pe $i
ttfautohint -v -f latn ${i::-4}.ttf ${i::-4}.ttf
sfnt2woff $i
mkeot $i -> ${i::-4}.eot
mkdir ${i::-4}-webfonts
cp $i ${i::-4}-webfonts/$i
mv ${i::-4}.ttf ${i::-4}-webfonts/${i::-4}-webfont.ttf
mv ${i::-4}.woff ${i::-4}-webfonts/${i::-4}-webfont.woff
mv ${i::-4}.svg ${i::-4}-webfonts/${i::-4}-webfont.svg
mv ${i::-4}.eot ${i::-4}-webfonts/${i::-4}-webfont.eot
echo "TTF, OTF, EOT and WOFF was generated, see $i-webfonts directory :)"
