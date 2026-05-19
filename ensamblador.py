"""
Script para convertir lenguaje ensamblador MIPS a binario.
Soporta instrucciones tipo R y tipo I para Fase 2.
Incluye soporte para etiquetas en BEQ.
"""

ARCHIVO_ENTRADA = "algoritmo.asm"
ARCHIVO_SALIDA = "TestF2_MemInst.mem"

registros = {
    "$zero": "00000",
    "$0":    "00000",

    "$t0": "01000",
    "$t1": "01001",
    "$t2": "01010",
    "$t3": "01011",
    "$t4": "01100",
    "$t5": "01101",
    "$t6": "01110",
    "$t7": "01111",

    "$s0": "10000",
    "$s1": "10001",
    "$s2": "10010",
    "$s3": "10011",
    "$s4": "10100",
    "$s5": "10101",
    "$s6": "10110",
    "$s7": "10111",
}

funct_r = {
    "add": "100000",
    "sub": "100010",
    "and": "100100",
    "or":  "100101",
    "slt": "101010",
}

opcode_i = {
    "addi": "001000",
    "slti": "001010",
    "andi": "001100",
    "ori":  "001101",
    "lw":   "100011",
    "sw":   "101011",
    "beq":  "000100",
}

def limpiar_linea(linea):
    linea = linea.split("#")[0]
    linea = linea.replace(",", " ")
    linea = linea.replace("(", " ")
    linea = linea.replace(")", " ")
    return linea.strip()

def inmediato_16(valor):
    numero = int(valor)
    if numero < 0:
        numero = (1 << 16) + numero
    return format(numero & 0xFFFF, "016b")

def traducir_tipo_r(partes):
    nombre = partes[0]
    rd = partes[1]
    rs = partes[2]
    rt = partes[3]

    return (
        "000000" +
        registros[rs] +
        registros[rt] +
        registros[rd] +
        "00000" +
        funct_r[nombre]
    )

def traducir_tipo_i(partes, pc, etiquetas):
    nombre = partes[0]

    if nombre in ["addi", "slti", "andi", "ori"]:
        rt = partes[1]
        rs = partes[2]
        imm = partes[3]

        return (
            opcode_i[nombre] +
            registros[rs] +
            registros[rt] +
            inmediato_16(imm)
        )

    if nombre in ["lw", "sw"]:
        rt = partes[1]
        offset = partes[2]
        rs = partes[3]

        return (
            opcode_i[nombre] +
            registros[rs] +
            registros[rt] +
            inmediato_16(offset)
        )

    if nombre == "beq":
        rs = partes[1]
        rt = partes[2]
        destino = partes[3]

        if destino in etiquetas:
            offset = etiquetas[destino] - (pc + 1)
        else:
            offset = int(destino)

        return (
            opcode_i[nombre] +
            registros[rs] +
            registros[rt] +
            inmediato_16(offset)
        )

    return None

# Leer archivo
with open(ARCHIVO_ENTRADA, "r", encoding="utf-8") as f:
    lineas_originales = f.readlines()

# Primera pasada: limpiar líneas y guardar etiquetas
lineas_codigo = []
etiquetas = {}
pc = 0

for linea in lineas_originales:
    l_limpia = limpiar_linea(linea)

    if l_limpia == "":
        continue

    if l_limpia.endswith(":"):
        nombre_etiqueta = l_limpia[:-1]
        etiquetas[nombre_etiqueta] = pc
    else:
        lineas_codigo.append(l_limpia)
        pc += 1

# Segunda pasada: traducir instrucciones
resultados = []

for pc, linea in enumerate(lineas_codigo):
    partes = linea.split()
    nombre_inst = partes[0].lower()

    if nombre_inst in funct_r:
        binario = traducir_tipo_r(partes)

    elif nombre_inst in opcode_i:
        binario = traducir_tipo_i(partes, pc, etiquetas)

    elif nombre_inst == "nop":
        binario = "00000000000000000000000000000000"

    else:
        print("Instrucción no soportada:", linea)
        continue

    resultados.append(binario)
    print(f"Traduciendo: {linea} -> {binario}")

with open(ARCHIVO_SALIDA, "w", encoding="utf-8") as f:
    for item in resultados:
        f.write(item[0:8] + "\n")
        f.write(item[8:16] + "\n")
        f.write(item[16:24] + "\n")
        f.write(item[24:32] + "\n")

print("\nArchivo TestF2_MemInst.mem generado correctamente.")
