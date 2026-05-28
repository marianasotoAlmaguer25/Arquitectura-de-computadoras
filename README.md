# PROYECTO FINAL: PROCESADOR MIPS 32-BIT


Este repositorio contiene el desarrollo integral, la evolución arquitectónica y la validación del procesador MIPS de 32 bits, diseñado y simulado como parte de los entregables prácticos del curso.

---

##  OBJETIVO DEL PROYECTO

Diseñar e implementar el *Single Datapath* (camino de datos único) de un procesador basado en la arquitectura MIPS de 32 bits, desarrollando e interconectando los módulos de hardware en Verilog necesarios para ejecutar de manera sólida instrucciones de Tipo R (registro a registro). 

Asimismo, validar el comportamiento del sistema mediante el desarrollo de un algoritmo en lenguaje ensamblador enfocado en encontrar el valor máximo entre registros sin el uso de instrucciones de salto, automatizando su traducción a código máquina binario a través de un script personalizado en Python y demostrando su correcto funcionamiento mediante simulaciones funcionales con los vectores de prueba oficiales de la cátedra.

---

## ESTRUCTURA DE ENTREGAS

El repositorio se encuentra organizado cronológicamente en las siguientes secciones:

* **`archivos_fase01/`**: Diseño del datapath básico, Unidad de Control inicial y script de traducción para instrucciones Tipo R (Algoritmo de Valor Máximo).
* **`archivos_fase02/`**: Evolución a arquitectura segmentada mediante buffers interetapas (IF/ID, ID/EX, EX/MEM, MEM/WB), soporte a instrucciones Tipo I/J y algoritmo Bubble Sort.
* **`archivos_fase03/`**: Implementación final con unidades de detección de riesgos (Hazards), cortocircuito (Forwarding) y optimización avanzada del Pipeline.

---

## 🛠️ TECNOLOGÍAS UTILIZADAS

* **Hardware (HDL):** Verilog
* **Software de Simulación:** ModelSim / QuestaSim
* **Automatización:** Python 3.x
* **Versionamiento:** Git & GitHub

---

