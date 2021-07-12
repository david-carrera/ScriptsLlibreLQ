#!/bin/env python3
# -*- coding: utf-8 -*-

import sys
import json
import html
import csv

"""
Per obtenir el fitxer .json:

* Ves a la pàgina de google n-grams (https://books.google.com/ngrams/) i
  realitza la consulta.

* Visualitza el codi font de la pàgina.

* Busca el text 'ngrams.data = '

* Copia la llista en format json

* Si s'han de realitzar més consultes, les llistes s'hauran de concatenar a mà
  dins el fitxer (esborrar l'últim ']' de la llista ja present, afegir un a
  coma ',' i enganxar la llista sense el primer ']'.

Aquestes instruccions són vàlides a data: 2020/07/12
"""


def main():
    if len(sys.argv) != 3:
        print("ús: neteja_ngrams.py ngrams.json resultat.csv")
        return 1

    with open(sys.argv[1]) as f:
        ngrams = json.load(f)

    years = [x for x in range(1800, 2019+1)]

    with open(sys.argv[2], 'w') as f:
        writer = csv.writer(f)
        writer.writerow(['year', 'proportion', 'ngram'])
        for d in ngrams:
            ngram = html.unescape(d['ngram'])
            proportions = d['timeseries']
            assert len(proportions) == len(years)
            rows = zip(years, proportions, len(years)*[ngram])
            writer.writerows(rows)

    return 0


if __name__ == '__main__':
    exit(main())
