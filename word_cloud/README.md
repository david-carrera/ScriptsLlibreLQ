# Núvol de Paraules

Aquest script genera la Figura 2 del llibre, un núvol de les 50 paraules més
freqüents en la declaració dels drets humans. Cada paraula apareix acompanyada
de la seva freqüència.

És un script de `python` que depèn del paquet `wordcloud`, que fa la feina més
complexa de col·locar les paraules en un núvol. El paquet es pot instal·lar
utilitzant `pip`:

```
pip3 install wordcloud==1.8.1
```

Per tal d'executar el script, és necessari tenir un fitxer csv amb les paraules
d'un text i les seves freqüències. Un fitxer d'exemple per a la declaració dels
drets humans, així com un script per generar fitxers semblants per a qualsevol
text, es pot trobar dins el subdirectori d'[anàlisis de text](../text_analysis).

Un exemple d'un núvol de paraules emblant al que apareix al llibre:

![Núvol de paraules de la declaració dels drets humans](word_cloud.png)

Aquest núvol de paraules s'ha generat a partir de la següent comanda:

```
python3 word_cloud.py --mostra-frequencies ../text_analysis/DeclaracioDretsHumansFrequencies.csv word_cloud.png
```

Es poden controlar molts aspectes de la generació del núvol de paraules sense
entrar dins el codi del script. Vegeu el resultat d'executar:

```
python3 word_cloud.py --help
```

També pot ser d'utilitat veure la documentació del paquet `wordcloud`,
disponible en anglès a https://amueller.github.io/word_cloud, aquest paquet
permet moltes més opcions de les utilitzades per aquest script.
