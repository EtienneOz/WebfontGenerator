# webfontgenerator 

## Description

A bash script to generate a webfont kit (font files and css files) from otf or ttf.

## Previews

![webfontgenerator](previews/Capture d'écran - 17042016 - 20:28:48.png)

## Install

Install those dependencies :

- woff-tools
- fontforge
- eot-utils
- ttfautohint



```
sudo apt-get install woff-tools fontforge eot-utils ttfautohint
```

You may need to pass executable mode on bash files

    sudo chmod +x webfontgenerator/webfontgenerator.bash webfontgenerator/clean_output.bash webfontgenerator/clean_input.bash

## Use

Déplacer les familles de fonts dans le dossier `/webfontgenerator/input/` en
respectant la hiérarchie suivante :

```
webfontgenerator/
    input/
	    famille-1/
		    font-A.(otf/ttf)
		    font-B.(otf/ttf)
		    font-C.(otf/ttf)
		    ...
	    famille-2/
		    font-A.(otf/ttf)
		    font-B.(otf/ttf)
		    font-C.(otf/ttf)
		    ...
```

Les noms des dossiers et des fichiers seront conservés pour la génération des fichiers
fonts et des feuilles de styles. Seuls les fichiers .otf ou .ttf sont supportés.

Lancer le generator

    ./webfontgenerator.bash

Les fichiers sont générés dans le dossier `/webfontgenerator/output/`

    cd /webfontgenerator/output/

## License

This script is under GNU GENERAL PUBLIC LICENSE V2, see LICENSE file for more infos.
