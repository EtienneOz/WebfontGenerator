# WebfontGenerator
A bash script to generate a webfont kit, currently alpha version, for linux.

# Dependencies
Please apt-get those four dependencies:  
`woff-tools`  
`fontforge`  
`eot-utils`  
`ttfautohint`

# Usage
This is a **very, very alpha version**. So far, you can :
* put your otf file in the `WebfontGenerator` directory, 
* `cd to/the/WebfontGenerator`
* run `bash generator.bash`. A prompt will ask you the font name, fill in and check the new directory.

# To do
* Allow multiple files input
* Allow ttf or otf input
* Associate a css stylesheet
* Use Scour to clean up svg

# License
This script is under **GNU GENERAL PUBLIC LICENSE V2**, see *LICENSE* file for more infos.
