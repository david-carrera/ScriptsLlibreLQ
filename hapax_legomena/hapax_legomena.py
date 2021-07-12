#!/bin/env python3
# -*- coding: utf-8 -*-

import sys
import csv

if __name__ == '__main__':
    if len(sys.argv) != 2:
        print("ús: hapax_legomena.py fitxer.csv")

    repeats = {}
    total = 0
    with open(sys.argv[1]) as f:
        reader = csv.DictReader(f)
        for row in reader:
            total += 1
            freq = int(row['freq'])
            if freq > 1:
                repeats[row['word']] = freq

    if repeats:
        print("Hi ha paraules repetides:")
        print(
            '\n'.join(
                "'{0}' apareix '{1}' vegades".format(word, freq)
                for word, freq in repeats.items()
            )
        )
    else:
        print("No hi ha paraules repetides.")
        print("{0} paraules en total".format(total))
