# -------------------------------------------------------------------------
# ALGORITMO: OBTENCIÓN DEL VALOR MÁXIMO (TIPO R)
# Entradas: $s0, $s1, $s2 (Valores a comparar)
# Salida:   $s3 (Contendrá el valor máximo)
# -------------------------------------------------------------------------

# PASO 1: Comparar $s0 y $s1
# Si $s0 < $s1, entonces $t0 = 1. Si no, $t0 = 0.
slt $t0, $s0, $s1

# PASO 2: "Simular" la elección del mayor entre el primer par.
# Si $t0 es 1, el mayor es $s1. Si es 0, el mayor es $s0.

add $t1, $s0, $zero   # Copiamos $s0 a $t1 temporalmente
and $t2, $t0, $s1     # Operación lógica para filtrar datos

# PASO 3: Comparar el resultado anterior con el tercer valor ($s2)
slt $t3, $t1, $s2     # ¿Es el mayor anterior menor que $s2?

# PASO 4: Resultado final al registro de destino
# Usamos OR para consolidar el valor máximo en $s3
or $s3, $t1, $s2      # Combinación final de registros