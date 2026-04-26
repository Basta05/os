#!/bin/bash

#
# Ověříme si, zda existuje adresář utf8. Pokud ne, vytvoříme jej
#
if [ ! -d utf8 ]
then
    mkdir utf8 ;
fi

#
# V cyklu provedeme založení potřebných souborů. Parametry
# načítáme ze souboru typu "HERE DOCUMENT", tj. vložený soubor.
# Co jeden řádek, to hodnoty dvou proměnných oddělených mezi
# sebou středníkem.
#
while IFS=';' read -r i j
do
    echo -e ${j} > utf8/${i} ;
done << EOF
c3ad;í
c3a1;á
c3a9;é
c3bd;ý
c48d;č
c48f;ď
c49b;ě
c5af;ů
c5a1;š
c5a5;ť
c5be;ž
c599;ř
0a;$
2c;,
2e;.
20;# 
21;!
22;"
3a;:
4a;J
4d;M
4e;N
4f;O
44;D
5a;Z
6a;j
6b;k
6c;l
6d;m
6e;n
6f;o
61;a
62;b
63;c
64;d
65;e
68;h
69;i
7a;z
70;p
72;r
73;s
74;t
75;u
76;v
79;y
EOF
