# Anàlisis de text

Aquest script tokenitza un fitxer de text i realitza un anàlisis senzill sobre
les paraules del text. El script depèn opcionalment del paquet `nltk` per a
tokenitzar el text. Si el paquet no es troba instal·lat, es fa servir una altra
rutina de tokenització més manual. `nltk` es pot instal·lar amb `pip`:

```
pip3 install nltk==3.6.2
```

Hi ha dos tipus d'anàlisi implementats, necessaris per a la generació de varies figures: 

* `freq` Troba el rang i freqüència de cada paraula del text.
* `dist` Troba el nombre de paraules distintes per al nombre de paraules totals del text.

El resultat d'aquest anàlisis es guarda en un fitxer csv.

En aquest directori es poden trobar els fitxers
[DeclaracioDretsHumansFrequencies.csv](DeclaracioDretsHumansFrequencies.csv) i
[DeclaracioDretsHumansDistintes.csv](DeclaracioDretsHumansDistintes.csv), el
resultat d'executar els dos anàlisis per al text de la declaració dels drets
humans. El text utilitzat es troba en una altra de les subcarpetes, [anàlisis
de text](../text_analysis).

Els mateixos resultats es poden obtenir executant

```
python3 text_analysis.py ../text_extraction/DeclaracioDretsHumans.txt freq -o DeclaracioDretsHumansFrequencies.csv
```

i

```
python3 text_analysis.py ../text_extraction/DeclaracioDretsHumans.txt dist -o DeclaracioDretsHumansDistintes.csv
```
