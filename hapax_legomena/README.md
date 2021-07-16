# Hapax Legomena

Aquest script determina si un text és o no un Hapax Legomena. És a dir, si
totes les paraules apareixen un sol cop. També informa sobre quines paraules
estan repetides en el text i quants cops hi apareixen.

El script pren com a paràmetre una fitxer csv amb la freqüència de cadascuna de
les paraules d'un text. Aquest repositori inclou un [script](../text_analysis)
de `python` per a generar aquest fitxer a partir d'un text.

Com a exemple, en aquest directori s'inclouen tant el text del repte HL del
llibre ([`repte_hl.txt`](repte_hl.txt)), així com el csv que resulta de
processar-lo amb el script d'anàlisi de text ([`repte_hl.csv`](repte_hl.csv)).

Es pot comprovar que, en efecte, el text del llibre és un Hapax Legomena amb la
comanda:

```
python3 hapax_legomena.py repte_hl.csv
```
