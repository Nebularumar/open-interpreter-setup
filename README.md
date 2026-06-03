# 🧠 Open Interpreter Setup

[![Python](https://img.shields.io/badge/Python-3.10%2B-blue)](https://www.python.org/)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)
[![Status](https://img.shields.io/badge/Status-Active-success)]()

Configuración lista para producción de [Open Interpreter](https://github.com/OpenInterpreter/open-interpreter) con **memoria persistente, soporte completo en español e integración Ollama**.

Ejecuta tareas complejas en tu máquina usando **Qwen2.5 Coder 14B** localmente, sin depender de APIs externas.

---

## ✨ Características

- ✅ **Soporte completo en español** — interfaz y prompts 100% traducidos
- 💾 **Memoria persistente** — el modelo recuerda contexto entre sesiones
- 🔧 **Offline-first** — funciona 100% en tu máquina con Ollama
- 🐛 **Bug fix integrado** — soluciona el problema de `{}` de modelos locales
- ⚡ **Optimizado para GPUs** — configuración para 12-16GB VRAM
- 📋 **Setup automático** — instalación en 4 pasos

---

## 🎯 Problemas que resuelve

### 1️⃣ Bug de función calling: respuesta `{}`
Cuando Qwen2.5 Coder (y otros modelos locales) reciben un schema de herramientas, LiteLLM activa function calling automáticamente, pero el modelo no lo maneja y responde `{}`.

**✓ Solución integrada:** el profile incluye `supports_functions: false` para forzar modo texto. Funciona perfectamente.

### 2️⃣ Sin memoria entre sesiones
Open Interpreter borra todo al cerrar. Esta configuración carga automáticamente `memory.md` y lo inyecta en el system prompt.

**✓ Uso simple:**
```
recuerda: batch size 1 con GPU de 12GB
```
El modelo guarda automáticamente sin intervención.

### 3️⃣ Interfaz en inglés
Los mensajes de Open Interpreter vienen hardcodeados. Incluimos `patch_spanish.sh` que traduce todo automáticamente.

---

## 🚀 Instalación rápida

### Requisitos previos
- **Python 3.10+** ([descargar](https://www.python.org/))
- **[Open Interpreter](https://github.com/OpenInterpreter/open-interpreter)**
- **[Ollama](https://ollama.com/)** con Qwen2.5 Coder 14B

#### 1️⃣ Instala Open Interpreter
```bash
pip install open-interpreter
```

#### 2️⃣ Descarga el modelo (primera vez)
```bash
ollama pull qwen2.5-coder:14b
```

#### 3️⃣ Clone este repositorio
```bash
git clone https://github.com/Nebularumar/open-interpreter-setup.git
cd open-interpreter-setup
```

#### 4️⃣ Aplica la configuración
```bash
# Copiar profile
cp profiles/default.yaml ~/.config/open-interpreter/profiles/default.yaml

# Crear memoria personalizada
cp memory_template.md ~/.config/open-interpreter/memory.md
nano ~/.config/open-interpreter/memory.md  # Edita con tus datos

# Traducir interfaz al español
bash patch_spanish.sh
```

#### 5️⃣ ¡Listo!
```bash
interpreter
```

**La primera ejecución es lenta (carga del modelo). Paciencia.** 🔄

---

## 💬 Sistema de memoria persistente

### Guardar información
Desde dentro del chat, escribe:
```
recuerda: uso batch_size=1 por GPU de 12GB
recuerda: prefiero ejemplos con Python
```

El modelo lo añade automáticamente a `memory.md`.

### Recuperar contexto
```
¿qué sabes de mí?
```

**Resultado:** el modelo carga automáticamente toda la memoria al arrancar.

---

## 📁 Estructura del proyecto

```
open-interpreter-setup/
├── profiles/
│   └── default.yaml           # Configuración (fix del bug + español)
├── memory_template.md         # Template para tu memoria personal
├── patch_spanish.sh           # Script de traducción
├── README.md                  # Este archivo
└── LICENSE
```

---

## 📊 Compatibilidad de modelos

| Modelo | Tag Ollama | Estado | Notas |
|--------|-----------|--------|-------|
| **Qwen2.5 Coder 14B** | `qwen2.5-coder:14b` | ✅ Recomendado | El mejor para código y tareas de sistema |
| Qwen2.5 14B | `qwen2.5:14b` | ✅ Funciona | Alternativa generalista |
| Qwen3 14B | `qwen3:14b` | ✅ Funciona | Generalista, errores ocasionales con `find` |
| Mistral 7B | `mistral:latest` | ⚠️ Limitado | Necesita prompts muy precisos |

> **Todos requieren** `supports_functions: false` en el profile.

---

## ⚙️ Configuración por GPU

<details>
<summary><b>12-16GB VRAM (RTX 3060, RTX 4060, etc.)</b></summary>

```yaml
# En profiles/default.yaml, añade:
llm:
  model: "ollama/qwen2.5-coder:14b"
  supports_functions: false
  
llm_kwargs:
  num_gpu: 1
```

Esperado: ~4-6 tokens/seg con batch_size=1

</details>

<details>
<summary><b>24GB+ VRAM (RTX 4090, A6000, etc.)</b></summary>

Puedes aumentar batch_size para más velocidad (observa VRAM).

</details>

---

## 🔄 Actualizar después de nuevas versiones

Cuando actualices Open Interpreter:
```bash
pip install --upgrade open-interpreter
bash patch_spanish.sh  # Reaplica la traducción
```

> Los archivos del paquete se sobrescriben en cada actualización, por eso hay que reparchear.

---

## 📝 Notas importantes

- **Textos en inglés:** Python tracebacks, salidas de `pip`, mensajes de dependencias siempre estarán en inglés — eso es externo a Open Interpreter.
- **Ollama debe estar corriendo:** `ollama serve` en otra terminal
- **Primer arranque es lento:** la primera ejecución carga todo en VRAM, ~1-2 minutos normal.

---

## 🤝 Contribuciones

¿Encontraste un bug? ¿Tienes una mejora?

1. Abre un [issue](https://github.com/Nebularumar/open-interpreter-setup/issues)
2. Fork → Branch → Commit → Push → PR

---

## 📄 Licencia

MIT License. Libre para usar, modificar y distribuir.

---

## 🔗 Links útiles

- [Open Interpreter](https://github.com/OpenInterpreter/open-interpreter) — Repo oficial
- [Ollama](https://ollama.com/) — Modelos locales
- [Qwen2.5 Coder 14B](https://huggingface.co/Qwen/Qwen2.5-Coder-14B-Instruct) — Ficha técnica del modelo
