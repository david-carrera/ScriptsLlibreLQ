# Anàlisis de text

Aquest script tokenitza un fitxer de text i realitza un anàlisis sobre
les paraules del text.

Hi ha dos tipus d'anàlisi implementats, necessaris per a la generació de varies figures: 

* `freq` Troba el rang i freqüència de cada paraula del text.
* `dist` Troba el nombre de paraules distintes per al nombre de paraules totals del text.

El resultat d'aquest anàlisis es guarda en un fitxer csv.

En el directori de [dades](../dades) es poden trobar els fitxers
[DeclaracioDretsHumansFrequencies.csv](../dades/DeclaracioDretsHumansFrequencies.csv) i
[DeclaracioDretsHumansDistintes.csv](../dades/DeclaracioDretsHumansDistintes.csv),
el resultat d'executar els dos anàlisis per al text de la declaració dels
[drets humans](../dades/DeclaracioDretsHumans.txt).

Els mateixos fitxers csv es poden obtenir executant

```
python3 text_analysis.py ../dades/DeclaracioDretsHumans.txt freq -o ../dades/DeclaracioDretsHumansFrequencies.csv
```

i

```
python3 text_analysis.py ../dades/DeclaracioDretsHumans.txt dist -o ../dades/DeclaracioDretsHumansDistintes.csv
```
