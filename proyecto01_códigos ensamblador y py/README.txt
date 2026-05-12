PROYECTO MIPS 32-BIT (FASE 1) - EQUIPO ALU-CINÓGENOS
---------------------------------------------------

Este archivo describe el proceso de ejecución para la validación del 
algoritmo y el script de traducción desarrollado por el equipo.

CONTENIDO DEL ZIP:
1. algoritmo.asm   - Código fuente con la lógica para hallar el valor máximo.
2. ensamblador.py  - Script de Python para traducir mnemónicos a binario.
3. README.txt      - Instrucciones de uso y notas de validación.

INSTRUCCIONES DE EJECUCIÓN (SCRIPT PYTHON):
1. Asegúrese de tener instalado Python 3.x en su sistema.
2. Coloque el archivo 'algoritmo.asm' en la misma carpeta que 'ensamblador.py'.
3. Ejecute el siguiente comando: > python ensamblador.py
4. El script generará un archivo binario que demuestra la capacidad de 
   traducción de instrucciones Tipo R.

NOTAS TÉCNICAS Y DE VALIDACIÓN (HARDWARE):
- El Datapath entregado en el ZIP de Código Verilog ha sido integrado y 
  validado exitosamente con los archivos oficiales proporcionados por el 
  profesor: 'TestF1_MemInst.mem' y 'TestF1_BReg.mem'.
- Dichos archivos (.mem) se encuentran incluidos dentro del ZIP 1 
  (Código Verilog) para que la simulación en ModelSim cargue las 
  instrucciones y datos de registro definidos por la cátedra de forma 
  automática.
- El script de Python incluido en este ZIP es la herramienta utilizada por 
  el equipo para automatizar la generación de código máquina para 
  propuestas de algoritmos personalizados.
