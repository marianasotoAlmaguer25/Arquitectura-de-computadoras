"""
Script para convertir lenguaje ensamblador a binario.
"""

# Definimos los archivos
ARCHIVO_ENTRADA = "algoritmo.asm"
ARCHIVO_SALIDA = "instrucciones.mem"

# Abrimos el archivo de texto
with open(ARCHIVO_ENTRADA, "r", encoding="utf-8") as f:
    lineas = f.readlines()

resultados = []

for linea in lineas:
    # Limpiamos espacios y comas
    l_limpia = linea.strip().replace(",", "")

    # Saltamos líneas vacías o comentarios
    if l_limpia == "" or l_limpia.startswith("#"):
        continue

    # Separamos la instrucción y los registros
    partes = l_limpia.split()
    nombre_inst = partes[0]
    rd_reg = partes[1]
    rs_reg = partes[2]
    rt_reg = partes[3]

    # Opcode para Tipo R
    OPCODE = "000000"

    # Pasamos RS a binario
    if rs_reg == "$s0": RS_BIN = "10000"
    elif rs_reg == "$s1": RS_BIN = "10001"
    elif rs_reg == "$s2": RS_BIN = "10010"
    elif rs_reg == "$zero": RS_BIN = "00000"
    else: RS_BIN = "01000"

    # Pasamos RT a binario
    if rt_reg == "$s0": RT_BIN = "10000"
    elif rt_reg == "$s1": RT_BIN = "10001"
    elif rt_reg == "$s2": RT_BIN = "10010"
    elif rt_reg == "$zero": RT_BIN = "00000"
    else: RT_BIN = "01001"

    # Pasamos RD a binario
    if rd_reg == "$s3": RD_BIN = "10011"
    elif rd_reg == "$t0": RD_BIN = "01000"
    elif rd_reg == "$t1": RD_BIN = "01001"
    else: RD_BIN = "00000"

    # Shamt siempre es 0
    SHAMT = "00000"

    # Código de operación (Funct)
    if nombre_inst == "add": FUNCT = "100000"
    elif nombre_inst == "sub": FUNCT = "100010"
    elif nombre_inst == "slt": FUNCT = "101010"
    elif nombre_inst == "or":  FUNCT = "100101"
    elif nombre_inst == "and": FUNCT = "100100"
    else: FUNCT = "000000"

    # Concatenamos los 32 bits
    BINARIO = OPCODE + RS_BIN + RT_BIN + RD_BIN + SHAMT + FUNCT
    resultados.append(BINARIO)
    print(f"Traduciendo: {l_limpia} -> {BINARIO}")

# Guardamos el resultado
with open(ARCHIVO_SALIDA, "w", encoding="utf-8") as f:
    for item in resultados:
        f.write(item + "\n")    

print("\nArchivo de memoria generado correctamente.")