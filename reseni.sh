#!/bin/bash

#
# Skript cte radky ze souboru vstup.csv, ktery obsahuje jmena 
# "skatulek s pismenky" - souboru v adresari utf8/.
# Kazda skatulka obsahuje jeden znak, pricemz:
#   - znak '$' reprezentuje konec radku
#   - znak '#' reprezentuje mezeru
# Ceske znaky jsou v UTF-8 dvoubajtove, takze jejich jmeno
# souboru je slozeno ze dvou radku vstup.csv - prvni bajt
# vzdy zacina znakem 'c'.
#

# Projdeme vsechny radky souboru vstup.csv
while IFS= read -r radek
do
    # Pokud radek zacina pismenem 'c', jde o prvni bajt
    # ceskeho (dvoubajtoveho) UTF-8 znaku - musime precist
    # i nasledujici radek a spojit je do jednoho jmena souboru.
    if [[ "${radek}" == c* ]]
    then
        read -r dalsi_bajt
        jmeno="${radek}${dalsi_bajt}"
    else
        jmeno="${radek}"
    fi

    # Nacteme obsah "skatulky". Pouziti $(...) automaticky
    # odstrani koncovy newline, ktery tam pridal 'echo -e'
    # ve skriptu zadani.sh.
    znak=$(cat "utf8/${jmeno}")

    # Prelozime specialni znaky na jejich skutecny vyznam:
    #   '$' -> konec radku (newline)
    #   '#' -> mezera
    # U ostatnich znaku staci vypsat je tak, jak jsou.
    case "${znak}" in
        '$') printf '\n' ;;
        '#') printf ' ' ;;
          *) printf '%s' "${znak}" ;;
    esac
done < vstup.csv
