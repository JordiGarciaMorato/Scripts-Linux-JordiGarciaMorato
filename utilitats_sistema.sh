#!/bin/bash
# ==============================================================================
# Script: utilitats_sistema.sh
# Descripcio: Script modular amb funcions per comprovar l'estat del sistema.
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
# Descripcio: Verifica si un nom d'usuari existeix al fitxer /etc/passwd.
# Parametres: $1 -> Nom d'usuari a comprovar
# ------------------------------------------------------------------------------
comprova_usuari() {
    local usuari="$1"
    
    # Comprovem si l'usuari existeix cercant-lo a /etc/passwd
    if grep -q "^${usuari}:" /etc/passwd; then
        echo "[EXIT] L'usuari '$usuari' SI que existeix al sistema."
    else
        echo "[AVIS] L'usuari '$usuari' NO existeix al sistema."
    fi
}

# ------------------------------------------------------------------------------
# Funcio: calculadora_espai
# Descripcio: Mostra l'espai lliure de la particio principal (/) utilitzant df -h.
# Parametres: Cap
# ------------------------------------------------------------------------------
calculadora_espai() {
    echo "--------------------------------------------------"
    echo "Informacio de l'espai lliure a la particio principal (/):"
    echo "--------------------------------------------------"
    df -h /
}

# ==============================================================================
# LOGICA PRINCIPAL DE L'SCRIPT
# ==============================================================================

# 1. Demanar el nom de l'alumne i cridar a la benvinguda
read -p "Introdueix el teu nom: " nom_alumne
benvinguda "$nom_alumne"

# 2. Demanar un nom d'usuari del sistema i comprovar-ho
read -p "Introdueix un nom d'usuari per comprovar si existeix: " nom_usuari
comprova_usuari "$nom_usuari"

# 3. Cridar a la funcio calculadora_espai per tancar l'execucio
calculadora_espai