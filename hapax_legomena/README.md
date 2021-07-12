# Hapax Legomena

Aquest script determina si un text és o no un Hapax Legomena. Utilitza el
fitxer csv de freqüències generat pel script que es troba al directori
d'[anàlisis de text](../text_analysis).

Com a exemple, en aquest directori s'inclouen tant el text del repte HL del
llibre ([`repte_hl.txt`](repte_hl.txt)), així com el csv que resulta de
processar-lo amb el script d'anàlisi de text ([`repte_hl.csv`](repte_hl.csv)).

Es pot comprovar que, en efecte, el text del llibre és un Hapax Legomena amb la
comanda:

```
python3 hapax_legomena.py repte_hl.csv
```
