#!/bin/bash

# Captura la salida del comando en una variable
paused=$(dunstctl is-paused)

# Verifica si dunst está pausado
if [[ "$paused" == "true" ]]; then
    # Si está pausado, devuelve un icono utf para "true"
    echo -e ""  # Icono de una cruz (✖)
else
    # Si no está pausado, devuelve un icono utf para "false"
    echo -e ""  # Icono de una marca de verificación (✅)
fi
