#!/usr/bin/env bash
# Traduce los mensajes de la UI de Open Interpreter al español.
# Probado con Open Interpreter 0.4.3 + Python 3.10.
# Si actualizas OI con pip, vuelve a ejecutar este script.

set -e

OI_PATH=$(python3 -c "import interpreter; import os; print(os.path.dirname(interpreter.__file__))")

if [ -z "$OI_PATH" ]; then
  echo "Error: Open Interpreter no encontrado. Instálalo primero."
  exit 1
fi

echo "Aplicando traducciones en: $OI_PATH"

TI="$OI_PATH/terminal_interface/terminal_interface.py"
LLM="$OI_PATH/core/llm/llm.py"
VAL="$OI_PATH/terminal_interface/validate_llm_settings.py"

# --- terminal_interface.py ---
sed -i 's/\*\*Open Interpreter\*\* will require approval before running code\./\*\*Open Interpreter\*\* requerirá aprobación antes de ejecutar código./g' "$TI"
sed -i "s/Use \`interpreter -y\` to bypass this\./Usa \`interpreter -y\` para omitir esto./g" "$TI"
sed -i "s/Press \`CTRL-C\` to exit\./Pulsa \`CTRL-C\` para salir./g" "$TI"
sed -i 's/Would you like to scan this code? (y\/n)/¿Quieres analizar este código? (s\/n)/g' "$TI"
sed -i 's/Would you like to run this code? (y\/n)/¿Quieres ejecutar este código? (s\/n)/g' "$TI"
sed -i 's/I have declined to run this code\./He rechazado ejecutar este código./g' "$TI"
sed -i 's/`Exiting\.\.\.`/`Saliendo...`/g' "$TI"

# Aceptar 's' además de 'y' en los prompts de confirmación
sed -i 's/response\.strip()\.lower() == "y":/response.strip().lower() in ("y", "s"):/g' "$TI"

# --- llm.py ---
sed -i 's/\*Model loaded\.\*/\*Modelo cargado.\*/g' "$LLM"
sed -i 's/print(f"Loading {model_name}\.\.\.\\n")/print(f"Cargando {model_name}...\\n")/g' "$LLM"
sed -i 's/Downloading {model_name}/Descargando {model_name}/g' "$LLM"
sed -i 's/Ollama not found/Ollama no encontrado/g' "$LLM"
sed -i 's/Please download Ollama from/Descarga Ollama desde/g' "$LLM"
sed -i 's/to use `/para usar `/g' "$LLM"

# --- validate_llm_settings.py ---
sed -i 's/Model set to `/Modelo: `/g' "$VAL"

echo "✓ Traducciones aplicadas correctamente."
echo "  Reinicia interpreter para que surtan efecto."
