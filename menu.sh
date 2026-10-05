#!/bin/bash
# ==============================================================================
# Script: menu.sh
# Descripcio: Script amb menu interactiu i suport de parametres per linia d'ordres.
# Autor: Jordi Garcia Morato
# ==============================================================================

# ------------------------------------------------------------------------------
# Funcio: benvinguda
# Descripcio: Rep un nom com a parametre i mostra un missatge personalitzat.
# Parametres: $1 -> Nom de l'alumne
# ------------------------------------------------------------------------------
benvinguda() {
    local nom="$1"
    echo "--------------------------------------------------"
    echo "Hola $nom, anem a comprovar el sistema."
    echo "--------------------------------------------------"
}

# ------------------------------------------------------------------------------
# Funcio: comprova_usuari
# Descripcio: Verifica si un nom d'usuari existeix utilitzant la comanda 'id'.
# Parametres: $1 -> Nom d'usuari a comprovar
# ------------------------------------------------------------------------------
comprova_usuari() {
    local usuari="$1"
    
    if [ -z "$usuari" ]; then
        read -p "Introdueix un nom d'usuari per comprovar: " usuari
    fi
    
    # Utilitzem 'id' i amaguem la sortida per pantalla amb &>/dev/null
    if id "$usuari" &>/dev/null; then
        echo "[EXIT] L'usuari '$usuari' SI que existeix al sistema."
    else
        echo "[AVIS] L'usuari '$usuari' NO existeix al sistema."
    fi
}

# ------------------------------------------------------------------------------
# Funcio: calculadora_espai
# Descripcio: Mostra l'espai lliure de la particio principal (/) amb df -h.
# Parametres: Cap
# ------------------------------------------------------------------------------
calculadora_espai() {
    echo "--------------------------------------------------"
    echo "Informacio de l'espai lliure a la particio principal (/):"
    echo "--------------------------------------------------"
    df -h /
}

# ------------------------------------------------------------------------------
# Funcio: mostrar_menu
# Descripcio: Mostra les opcions del menu interactiu per pantalla.
# ------------------------------------------------------------------------------
mostrar_menu() {
    echo ""
    echo "=========================================="
    echo "           MENU DE GESTIO SYSTEM          "
    echo "=========================================="
    echo "1. Benvinguda personalitzada"
    echo "2. Comprovar si un usuari existeix"
    echo "3. Consultar espai en disc (/)"
    echo "4. Sortir"
    echo "=========================================="
}

# ==============================================================================
# LOGICA PRINCIPAL (MODE PARAMETRES O MODE INTERACTIU)
# ==============================================================================

# Si es passen parametres per linia d'ordres
if [ $# -gt 0 ]; then
    case "$1" in
        1|-1)
            benvinguda "${2:-Alumne}"
            ;;
        2|-2|--comprova|-a|--add)
            comprova_usuari "$2"
            ;;
        3|-3|--espai)
            calculadora_espai
            ;;
        *)
            echo "Opcio no valida per parametre. Utilitza: 1, 2 o 3."
            ;;
    esac
    exit 0
fi

# Mode interactiu (bucle fins que l'usuari triï sortir)
opcio=0
while [ "$opcio" -ne 4 ]; do
    mostrar_menu
    read -p "Escull una opcio (1-4): " opcio
    
    case "$opcio" in
        1)
            read -p "Introdueix el teu nom: " nom_alumne
            benvinguda "$nom_alumne"
            ;;
        2)
            read -p "Introdueix el nom d'usuari a comprovar: " nom_usuari
            comprova_usuari "$nom_usuari"
            ;;
        3)
            calculadora_espai
            ;;
        4)
            echo "Sortint del programa. Adeu!"
            ;;
        *)
            echo "[ERROR] Opcio incorrecta. Si us plau, tria un nombre del 1 al 4."
            ;;
    esac

    if [ "$opcio" -ne 4 ]; then
        echo ""
        read -p "Prem [Enter] per continuar..."
    fi
done