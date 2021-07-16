# Anàlisis de text

Aquest script tokenitza un fitxer de text i realitza un anàlisis sobre
les paraules del text.

Hi ha dos tipus d'anàlisi implementats, necessaris per a la generació de varies figures: 

* `freq` Troba el rang i freqüència de cada paraula del text.
* `dist` Troba el nombre de paraules distintes per al nombre de paraules totals del text.

El resultat d'aquest anàlisis es guarda en un fitxer csv.

En aquest directori es poden trobar els fitxers
[DeclaracioDretsHumansFrequencies.csv](DeclaracioDretsHumansFrequencies.csv) i
[DeclaracioDretsHumansDistintes.csv](DeclaracioDretsHumansDistintes.csv), el
resultat d'executar els dos anàlisis per al text de la declaració dels [drets
humans](../text_extraction/DeclaracioDretsHumans.txt).

Els mateixos fitxers csv es poden obtenir executant

```
python3 text_analysis.py ../text_extraction/DeclaracioDretsHumans.txt freq -o DeclaracioDretsHumansFrequencies.csv
```

i

```
python3 text_analysis.py ../text_extraction/DeclaracioDretsHumans.txt dist -o DeclaracioDretsHumansDistintes.csv
```
