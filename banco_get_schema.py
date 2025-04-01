import sqlite3

# filepath: /path/to/your/script.py
# Conectar a la base de datos
conexion = sqlite3.connect('<path-folder>/Banco.sqlite')

# Crear un cursor
cursor = conexion.cursor()

# Obtener nombres de las tablas
cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
tablas = cursor.fetchall()

print("Tablas en la base de datos:")
for tabla in tablas:
    print(f"- {tabla[0]}")
    # Obtener estructura de cada tabla
    cursor.execute(f"PRAGMA table_info('{tabla[0]}');")
    columnas = cursor.fetchall()
    print("  Columnas:")
    for columna in columnas:
        print(f"    {columna}")

# Cerrar la conexión
conexion.close()