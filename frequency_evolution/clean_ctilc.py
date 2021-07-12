#!/bin/env python3
# -*- coding: utf-8 -*-

import os
import sys
import csv

"""
Per crear el directori i els fitxers de text:

* Ves a la pàgina del CTILC
  (https://ctilc.iec.cat/scripts/CTILCQConc_Lemes1.asp) i realitza la consulta.

* En la part esquerra, desplega "Filtres" i "Filtra per any de
  publicació". Desplega cadascun dels rangs que apareixen.

* Copia totes les linies de text després de "Filtra per any de publicació" i
  abans de "Filtra per tipus", sense inclure aquestes.

* Copia aquestes linies al seu propi fitxer, que ha de tenir com a nom el lema que s'ha buscat (incluent accents) i com a extensió '.txt.

* Crear també el fitxer total.txt: Les dades es poden trobar a
  https://ctilc.iec.cat/scripts/CTILCQDadesNum.asp i el fitxer resultant es pot
  ajustar al mateix format que els altres, per exemple amb l'ús de macros d'un
  editor de text.
"""


def parse(text):
    result = {}

    for line in text.split('\n'):
        line = line.strip()
        if not line or '-' in line:
            continue

        yearstr, amountstr = line.split()
        year = int(yearstr)
        assert amountstr[0] == '[' and amountstr[-1] == ']'
        amount = int(amountstr[1:][:-1])

        assert year not in result
        result[year] = amount

    return result


def collect_words(root):
    words = {}

    for filename in next(os.walk(root))[2]:
        if not filename.endswith('.txt'):
            continue

        path = os.path.join(root, filename)
        with open(path) as f:
            fulltext = f.read()
        data = parse(fulltext)

        word = os.path.splitext(filename)[0]
        words[word] = data

    return words


def tocsv(words, filename):
    with open(filename, 'w') as f:
        writer = csv.writer(f)
        writer.writerow(['year', 'proportion', 'ngram'])
        for word, data in words.items():
            if word == 'total':
                continue
            for year, amount in data.items():
                proportion = amount / words['total'][year]
                writer.writerow([year, proportion, word])


def main():
    if len(sys.argv) != 3:
        print("ús: neteja_ctilc.py directori/amb/txts resultat.csv")
        return 1

    words = collect_words(sys.argv[1])

    if 'total' not in words:
        print("no s'ha trobat el fitxer total.txt")
        return 1

    tocsv(words, sys.argv[2])
    return 0


if __name__ == '__main__':
    exit(main())
