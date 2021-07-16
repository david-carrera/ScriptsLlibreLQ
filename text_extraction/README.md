# Extracció de text

Tot i que existeixen molts llocs web on s'ofereixen conversions del tipus PDF a
text pla, es possible realitza aquestes extraccions de text de forma local. El
paquet [`textract`](https://textract.readthedocs.io/en/latest/) de `python`
permet extreure text de formats molt diversos segons la seva documentació. El
paquet es pot instal·lar fàcilment:

```
pip install textract
```

El text de la declaració dels drets humans, disponible a
https://www.ohchr.org/EN/UDHR/Pages/Language.aspx?LangID=cln, en format PDF,
s'ha convertit a text utilitzant aquesta eina. El resultat és el fitxer
[DeclaracioDretsHumans.txt](DeclaracioDretsHumans.txt).

La instal·lació del paquet posa a disposició la comanda `textract`:

```
textract DeclaracioDretsHumans.pdf > DeclaracioDretsHumans.txt
```
